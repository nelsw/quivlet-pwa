<template>
  <v-row
      justify="center"
  >
    <v-dialog
        v-model="dialog"
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
                    required
                    persistent-hint
                    label="What name should be displayed during the contest?"
                    hint="... or leave it blank and let us pick a name at random 🙃"
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
              x-large
              v-text="`Join the fun!`"
              color="blue darken-1"
              @click="$emit('handleOk')"
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
    dialog: Boolean,
  },
}
</script>