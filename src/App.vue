<template>
  <v-app>
    <AppBar
        :user="user"
    />
    <v-main>
      <Hero
          :show="hero"
          @handleOk="user.name = $event; hero = false; registerUser()"
      />
      <Challenge
          :item="item"
          @handleAnswer="answer=$event"
      />
      <ProgressDialog
          :visible="progressVisible"
          :text="progressText"
      />
      <v-snackbar
          multi-line
          v-model="snackbarVisible"
      >
        {{ snackbarText }}
        <v-btn
            text
            v-text="`Close`"
            color="red"
            @click="snackbarVisible = false"
        />
      </v-snackbar>
      <ErrorAlert
          :text="errorText"
      />
    </v-main>
    <Footer
        :timestamp="timestamp"
        :countdown="countdown"
        :user="user"
    />
  </v-app>
</template>

<script>
import Hero from '@/components/container/Hero';
import ProgressDialog from "@/components/dialog/ProgressDialog";
import Challenge from "@/components/container/Challenge";
import axios from "axios";
import moment from 'moment'
import AppBar from "@/components/bar/AppBar";
import Footer from "@/components/footer/Footer";
import ErrorAlert from "@/components/alert/ErrorAlert";

const userUrl = `https://irx9tvlcjj.execute-api.us-east-1.amazonaws.com/dev/user`
const sessUrl = `https://irx9tvlcjj.execute-api.us-east-1.amazonaws.com/dev/session`
const itemUrl = `https://irx9tvlcjj.execute-api.us-east-1.amazonaws.com/dev/challenge`

export default {
  namespaced: true,

  components: {
    ErrorAlert,
    Footer,
    AppBar,
    Challenge,
    ProgressDialog,
    Hero,
  },

  data: () => ({

    errorText: null,

    timestamp: null,
    countdown: false,

    // item (aka Challenge)
    index: -1,
    item: null,
    itemOpen: null,
    itemClose: null,
    answer: null,

    user: {
      token: null,
      result: []
    },
    session: {
      token: null,
    },

    // component visibility
    snackbarVisible: false,
    progressVisible: false,
    hero: true,

    snackbarText: null,
    progressText: null,
  }),

  mounted() {
    this.updateTimestamp()
  },

  methods: {

    updateTimestamp() {
      this.timestamp = moment().format("M/D/YY h:mm:ss")
      setTimeout(() => this.updateTimestamp(), 1000);
    },

    registerUser() {
      this.user.save = true
      this.progressVisible = true
      this.progressText = 'Configuring your Quivlet user ...';
      axios
          .post(userUrl+'?new=id', this.user, {})
          .then(result => this.user = result.data)
          .catch(error => this.errorText = error.text)
          .finally(() => this.findContest())
    },

    findContest() {
      this.progressText = 'Finding a contest to join ...';
      axios
          .post(sessUrl + '?find=id', {}, {})
          .then(result => this.session = result.data)
          .catch(error => this.errorText = error.text)
          .finally(() => this.handleStart())
    },

    handleStart() {
      this.itemOpen = moment.unix(this.session.expiry)

      this.progressText = 'Standby - starting shortly ... '
      let diff = this.itemOpen.diff(moment(), 'milliseconds')

      if (diff > 60 * 1000) {
        setTimeout(() => this.findContest(), 5 * 1000)
      } else {
        this.progressText = `Standby - Starting ${this.itemOpen.fromNow()}`
        setTimeout(() => this.fetchChallenge(), diff)
      }
    },

    fetchChallenge() {
      this.progressVisible = false
      axios
          .post(itemUrl, {token: this.user.token, index: this.index + 1}, {})
          .then(result => this.item = result.data)
          .catch(error => this.errorText = error.text)
          .then(() => this.countdown = true)
          .finally(() => setTimeout(() => this.fetchSolution(), 11 * 1000))
    },

    fetchSolution() {

      axios
          .post(itemUrl + '?solve=this', this.item, {})
          .then(result => {

            console.log(result.data)
            console.log(this.answer)
            this.item = null

            if (this.answer === result.data.correct_answer) {
              this.progressText = 'Correct! Advancing to the next round ...'
              this.progressVisible = true
              this.user.result.push(1000000000)

            } else if (this.answer && this.answer !== result.data.correct_answer) {
              this.snackbarText = 'Sorry ... the answer you selected was incorrect, try another contest!'
              this.snackbarVisible = true
              this.user.eliminated = true
              this.hero = true
            } else {
              this.snackbarText = 'Oops ... looks like you forgot to answer, thanks for playing!'
              this.snackbarVisible = true
              this.user.eliminated = true
              this.hero = true
            }
          })
          .catch(error => this.errorText = error.text)
          .finally(() => this.updateUser())
    },

    updateUser() {
      console.log(this.user)
      axios
          .post(userUrl, this.user, {})
          .then(result => {
            if (!result.data.eliminated) {
              this.checkIfWinner()
            }
          })
          .catch(error => this.errorText = error.text)
          .finally(() => {
            if (!this.user.eliminated) {

              this.fetchChallenge()
            }
          })
    },

    checkIfWinner() {
      console.log(this.user)
      axios
          .post(userUrl + '?find=all', this.user, {})
          .then(result => {
            console.log(result.data)
            if (result.data.filter(user => !user.eliminated).reduce((a, b) => a + b, 0) === 1) {
              this.snackbarText = 'Congrats ... you have won the Quivlet Trivia Contest!'
              this.snackbarVisible = true
              this.challenge = false
              this.hero = true
            }
          })
          .catch(error => this.errorText = error.text)
      .finally(() => {
        let milli = moment().add(1, 'minute').seconds(0).diff(moment(), 'milliseconds')
        console.log(milli)
        setTimeout(() => this.fetchChallenge(), milli)
      })
    },

  },
};
</script>
