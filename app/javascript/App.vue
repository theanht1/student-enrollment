<template lang="pug">
  div
    el-container
      header-component(v-if="$route.name !== 'Login'")
      router-view
</template>

<script>
  import HeaderComponent from './components/HeaderComponent'

  export default {
    name: 'Nhom2',

    components: {
      HeaderComponent,
    },
  }
</script>
