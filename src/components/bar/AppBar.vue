<template>
  <v-app-bar
      app
      color="primary"
      dark
  >
    <div
        class="d-flex align-center"
    >
      <v-img
          contain
          alt="Vuetify Logo"
          class="shrink mr-2"
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png"
          transition="scale-transition"
          width="40"
      />
      <span
          class="display-1 ml-2 font-weight-bold"
          v-text="`Quivlet`"
      />
    </div>
    <v-spacer/>
  </v-app-bar>
</template>

<script>
export default {
  namespaced: true
}
</script>