<template>
  <div>
    <v-navigation-drawer
        v-model="drawer"
        app
        right
        clipped
        stateless
    >
      <v-list
          dense
      >
        <v-list-item
            v-for="(value, index) in users"
            :key="index"
        >
          <v-list-item-content>
            <v-list-item-title>
              <v-badge
                  inline
                  :content="index + 1"
                  :color="index === 0 ? `success`: value.eliminated ? `danger` : `warning`"
              />
              {{ value.name }}
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-app-bar
        app
        clipped-right
        color="primary"
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
      <v-btn
          text
          x-large
          v-text="`Contestants`"
          :disabled="users.length < 1"
          @click="drawer=!drawer;"
      />
    </v-app-bar>
  </div>
</template>

<script>
import axios from "axios";

const url = `https://irx9tvlcjj.execute-api.us-east-1.amazonaws.com/dev/user?find=all`

export default {
  namespaced: true,

  props: {
    user: Object,
  },

  data: () => ({
    drawer: false,
    button: false,
    users: [],
  }),

  watch: {
    user() {
      if (this.user.token !== null) {
        this.pollUsers()
      }
    },
  },

  methods: {
    pollUsers() {
      axios
          .post(url, this.user, {})
          .then(result => this.users = result.data)
          .catch(error => this.errorText = error.text)
          .finally(() => setTimeout(() => this.pollUsers(), 5 * 1000))
    },
  },
}
</script>