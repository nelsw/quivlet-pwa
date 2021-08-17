<template>
  <v-app>
    <AppBar/>
    <v-main>
      <Hero/>
    </v-main>
  </v-app>
</template>

<script>
import Hero from '@/components/container/Hero';
import AppBar from "@/components/bar/AppBar";

export default {
  name: 'App',

  components: {
    AppBar,
    Hero,
  },

  data: () => ({
    //
  }),
};
</script>
