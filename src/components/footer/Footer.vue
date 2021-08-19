<template>
  <v-footer
      app
  >
    <span
        v-text="timestamp"
    />
    <v-spacer/>
    <span
        class="text-h6"
        style="color: deeppink"
        v-show="countdown && timeLimit > 1"
        v-text="timeLimit"
    />
    <v-spacer/>
    <span
        v-show="user.name"
        v-text="`Username: ${user.name}`"
    />
    <v-spacer/>
    <span
        style="color: rgb(29, 32, 33) !important;"
        v-text="timestamp"
    />
  </v-footer>
</template>

<script>
import moment from "moment";

export default {
  namespaced: true,

  props: {
    countdown: Boolean,
    user: Object,
  },

  data: () => ({
    timestamp: null,
    timeLimit: 0,
  }),

  mounted() {
    this.updateTimestamp()
  },

  watch: {

    countdown() {
      if (this.countdown) {
        this.timeLimit = 10
      }
    },

    timeLimit() {
      if (this.timeLimit > 0) {
        setTimeout(() => this.timeLimit--, 1000);
      }
    },
  },

  methods: {
    updateTimestamp() {
      this.timestamp = moment().format("M/D/YY h:mm:ss")
      setTimeout(() => this.updateTimestamp(), 1000);
    },
  },
}
</script>