<template>
  <v-container
      v-if="item"
  >
    <v-row
        align="center"
        justify="center"
        style="height:100vh"
    >
      <v-col
          xl="6"
          lg="8"
          md="10"
          sm="12"
      >
        <v-card
            class="justify-center"
        >
          <v-card-title>
          <span
              class="text-h3"
              v-text="`Question #${item.index + 1}`"
          />
          </v-card-title>
          <v-card-subtitle
              class="text-h5 mt-1"
              v-text="`Category: ${item.category}`"
          />
          <v-card-text>
            <v-container>
              <v-row
                  align="center"
                  justify="center"
              >
                <v-col
                    xl="9"
                    lg="8"
                    md="7"
                    sm="6"
                >
                  <span
                      class="text-h6"
                      v-text="item.question"
                  />
                </v-col>
                <v-col>
                  <v-radio-group
                      v-model="answer"
                  >
                    <v-radio
                        v-for="option in item.incorrect_answers"
                        :key="option"
                        :label="option"
                        :value="option"
                    />
                  </v-radio-group>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  namespaced: true,
  props: {
    item: Object,
  },
  watch: {
    answer(){
      if (this.answer) {
        this.$emit('handleAnswer', this.answer)
      }
    },
  },
  data: () => ({
    answer: null,
  }),
}
</script>