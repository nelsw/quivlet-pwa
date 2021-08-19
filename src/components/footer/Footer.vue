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
        v-show="timeLimit > 0"
        v-text="timeLimit"
    />
    <v-spacer/>
    <span
        v-text="user.name"
    />
  </v-footer>
</template>

<script>
export default {
  namespaced: true,

  props: {
    countdown: Boolean,
    timestamp: String,
    user: Object,
  },

  data: () => ({
    timeLimit: 0,
  }),

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
}
</script>