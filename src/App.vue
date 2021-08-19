<template>
  <v-app>
    <AppBar
        :user="user"
        @handleWinner="winner = $event"
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

    winner: null,

    errorText: null,

    countdown: false,

    // item (aka Challenge)
    index: -1,
    item: null,
    itemOpen: null,
    answer: null,

    user: {
      name: null,
      token: null,
      result: [],
      save: true, // to avoid persistence on preflight requests
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

  watch: {
    item() {
      this.countdown = !!this.item
    },
    snackbarText() {
      this.snackbarVisible = true
    },
    progressText() {
      this.progressVisible = !!this.progressText
    },
    winner() {
      if (this.winner === this.user.id) {
        this.snackbarText = 'Congrats ... you have won the Quivlet Trivia Contest!'
        this.item = null
        this.hero = true
      }
    },
  },

  methods: {

    resetContest() {

      // "pages"
      this.challenge = false
      this.hero = true

      // dialogs
      this.progressText = null
      this.snackbarText = null

      // challenge data
      this.index = -1
      this.countdown = false
      this.winner = null

      // entities
      this.user = {
        token: null,
        result: [],
        save: true, // to avoid persistence on preflight requests
      }
      this.session = {
        token: null,
      }
      this.item = null
    },

    registerUser() {
      this.progressText = 'Configuring your Quivlet user ...';
      axios
          .post(userUrl + '?new=id', this.user, {})
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

      this.progressText = 'Standby - starting shortly ... '

      let expiry = moment.unix(this.session.expiry)
      let diff = expiry.diff(moment(), 'milliseconds')

      if (diff > 60 * 1000) {
        setTimeout(() => this.findContest(), 5 * 1000)
      } else {
        this.progressText = `Standby - Starting ${expiry.fromNow()}`
        setTimeout(() => this.fetchChallenge(), diff)
      }
    },

    fetchChallenge() {

      if (this.winner !== null) {
        return
      }

      this.index = this.index + 1
      this.progressText = null
      this.item = null

      axios
          .post(itemUrl, {token: this.user.token, index: this.index}, {})
          .then(result => {
            this.item = result.data
            setTimeout(() => this.fetchSolution(), 10 * 1000)
          })
          .catch(error => this.errorText = error.text)
    },

    fetchSolution() {

      if (this.winner !== null) {
        return
      }

      axios
          .post(itemUrl + '?solve=this', this.item, {})
          .then(result => {

            this.user.eliminated = !this.answer || this.answer !== result.data.correct_answer

            if (!this.user.eliminated) {

              this.progressText = 'Correct! Advancing to the next round ...'
              this.user.result.push(this.index)

              axios
                  .post(userUrl + '?save=id', this.user, {})
                  .catch(error => this.errorText = error.text)
                  .finally(() => {
                    if (this.winner === null) {
                      this.fetchChallenge()
                    }
                  })

            } else {

              if (this.answer) {
                this.snackbarText = 'Sorry ... the answer you selected was incorrect, try another contest!'
              } else {
                this.snackbarText = 'Oops ... looks like you ran out of time, thanks for playing!'
              }

              axios
                  .post(userUrl + '?save=id', this.user, {})
                  .catch(error => this.errorText = error.text)

              setTimeout(() => this.resetContest(), 5 * 1000)
            }
          })
          .catch(error => this.errorText = error.text)
    },
  },
};
</script>
