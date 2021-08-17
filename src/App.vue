<template>
  <v-app>
    <AppBar/>
    <v-main>
      <Hero
          :show="hero"
          @handleOk="handleOk"
      />
      <Challenge
          :show="challenge"
      />
      <ProgressDialog
          :dialog="dialog"
          :message="message"
      />
    </v-main>
  </v-app>
</template>

<script>
import Hero from '@/components/container/Hero';
import AppBar from "@/components/bar/AppBar";
import ProgressDialog from "@/components/dialog/ProgressDialog";
import Challenge from "@/components/container/Challenge";

const message1 = `Standby - Preparing the next round ...`

export default {
  namespaced: true,

  components: {
    Challenge,
    ProgressDialog,
    AppBar,
    Hero,
  },

  data: () => ({
    dialog: false,
    hero: true,
    challenge: false,
  }),

  computed: {
    message() {
      return message1
    }
  },

  methods:{
    handleOk() {
      this.hero = false
      // this.dialog = true
      this.challenge = true
    },
  },
};
</script>
