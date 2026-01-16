<template>
  <ion-header :translucent="true">
    <ion-toolbar>
      <ion-title>
        Licznik
      </ion-title>
    </ion-toolbar>
  </ion-header>

  <ion-content :fullscreen="true">
    <ion-header collapse="condense">
      <ion-toolbar>
        <ion-title size="large">Licznik</ion-title>
      </ion-toolbar>
    </ion-header>

    <div class="ion-padding">
      <div class="counter-container">
        <h1 class="counter-display">{{ counter }}</h1>
        <ion-button expand="block" @click="incrementCounter" color="primary">
          Zwiększ licznik
        </ion-button>
      </div>
    </div>
  </ion-content>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import {
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent,
  IonButton
} from '@ionic/vue';

const counter = ref(0);

const incrementCounter = () => {
  counter.value += 1;
};
</script>

<style scoped>
.counter-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  padding: 2rem;
}

.counter-display {
  font-size: 4rem;
  font-weight: bold;
  color: var(--ion-color-primary);
  margin-bottom: 2rem;
  text-align: center;
}
</style>

