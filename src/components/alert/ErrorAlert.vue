<template>
  <v-container
      v-if="text"
  >
    <v-row>
      <v-col>
        <v-alert
            dense
            outlined
            type="error"
        >
          {{ content }}
        </v-alert>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  namespaced: true,
  props: {
    text: String,
  },
  computed: {
    content() {
      return `${this.text} ... try refreshing your browser and reattempting the desired operation.`
    }
  }
}
</script>