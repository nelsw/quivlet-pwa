<template>
  <v-container
      v-show="show"
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
              v-text="`Question #${index}`"
          />
            <v-spacer/>
            <Countdown
              @handleTimeExpired="handleTimeExpired"
            />
          </v-card-title>
          <v-card-subtitle
              class="text-h5 mt-1"
              v-text="`Category: ${category}`"
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
                      v-text="question"
                  />
                </v-col>
                <v-col>
                  <v-radio-group
                      v-model="answer"
                      :disabled="disabled"
                  >
                    <v-radio
                        v-for="option in options"
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
import Countdown from "@/components/timer/Countdown";
export default {
  components: {Countdown},
  namespaced: true,
  props: {
    show: Boolean,
  },
  data: () => ({
    disabled: false,
    index: 1,
    category: 'Vehicles',
    question: 'Which of the following passenger jets is the longest?',
    answer: '',
    options: [
      'Airbus A350-1000',
      'Airbus A330-200',
      'Boeing 787-10',
    ]
  }),
  methods: {
    handleTimeExpired() {
      this.disabled = true
    },
  }
}
</script>