<template>
  <v-row
      justify="center"
  >
    <v-dialog
        persistent
        v-model="visible"
        max-width="600px"
    >
      <v-card>
        <v-card-title>
          <span
              class="text-h5"
              v-text="`Enter the next round of trivia!`"
          />
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col
                  cols="12"
              >
                <v-text-field
                    v-model="name"
                    required
                    autofocus
                    persistent-hint
                    label="What would you like to be called?"
                    hint="... or leave it blank and we'll pick a random name 🙃"
                    @keypress.enter="$emit('handleOk', name)"
                />
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-btn
              text
              x-small
              v-text="`Maybe next time`"
              @click="$emit('handleCancel')"
          />
          <v-spacer/>
          <v-btn
              ref="btn"
              x-large
              v-text="`Join the fun!`"
              color="blue darken-1"
              @click="$emit('handleOk', name)"
          />
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
export default {
  namespaced: true,
  props: {
    visible: Boolean,
  },
  data: () => ({
    name: null,
  }),
}
</script>