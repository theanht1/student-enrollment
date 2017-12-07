<template lang="pug">
  div
    el-container
      header-component(v-if="$route.name !== 'Login'")

    el-container(style="margin-top: 40px")
      router-view(style="margin: 30px auto")

    el-footer(style="margin-top: 50px")
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

<style>
  body {
    font-family: Helvetica Neue,Helvetica,PingFang SC,Hiragino Sans GB,Microsoft YaHei,SimSun,sans-serif;
    margin: 0px;
  }
</style>
