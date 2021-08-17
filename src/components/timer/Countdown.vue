<template>
  <span
      v-text="countdown"
  />
</template>

<script>
export default {
  namespaced: true,

  data: () => ({
    countdown: 10,
  }),

  watch: {
    countdown: {
      handler(value) {
        if (value > 0) {
          setTimeout(() => {
            this.countdown--;
          }, 1000);
        } else {
          this.$emit('handleTimeExpired')
        }
      },
      immediate: true // This ensures the watcher is triggered upon creation
    }
  },
}
</script>