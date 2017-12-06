<template lang="pug">
  el-header(:class="$style.header")
    el-row(type="flex" align="middle")
      el-col(:span="4" style="width: 300px")
        router-link(to="/")
          h1 Hỗ trợ tuyển sinh

      el-col(:span="22")
        el-menu(
          :class="$style.menu"
          mode="horizontal"
          background-color="#f9f9f9"
          text-color="black"
        )
          router-link(v-if="!isAuthenticated" to="/login")
            el-menu-item(index="3") Đăng nhập

          div(v-else)
            el-menu-item(index="3" @click="logout") Đăng xuất

            router-link(to="/settings")
              el-menu-item(index="2") Cài đặt

          el-menu-item(:class="$style.welcome" index="1" style="border: none !important;") Xin chào,
            span  {{ user.name }}
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState({
        isAuthenticated: state => state.auth.isAuthenticated,
        user: state => state.auth.user,
      }),
    },

    methods: {
      logout() {
        return this.$store.dispatch('logout')
      },
    },
  }
</script>

<style module>
  .header {
    background-color: #f9f9f9;
    width: 100vw;
    text-align: center;
  }

  .menu {
    border: none;

    & li {
      float: right !important;
      margin: * 20px * * !important;
      border-bottom: 2px solid #008000 !important;
    }
  }

  .welcome {
    & span {
      color: #409EFF;
      font-weight: 700;
    }
  }

</style>
