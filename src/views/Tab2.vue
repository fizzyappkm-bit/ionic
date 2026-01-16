<template>
  <ion-header :translucent="true">
    <ion-toolbar>
      <ion-title>
        Tab 2
      </ion-title>
    </ion-toolbar>
  </ion-header>

  <ion-content :fullscreen="true">
    <ion-header collapse="condense">
      <ion-toolbar>
        <ion-title size="large">Tab 2</ion-title>
      </ion-toolbar>
    </ion-header>

    <ExploreContainer name="Tab 2 page" />
  </ion-content>
</template>

<script setup lang="ts">
import {
  IonHeader,
  IonToolbar,
  IonTitle,
  IonContent
} from '@ionic/vue';
import ExploreContainer from '../components/ExploreContainer.vue';
</script>

