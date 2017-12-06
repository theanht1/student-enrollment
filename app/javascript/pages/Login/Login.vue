<template lang="pug">
  div(:class="$style.loginPage")
    el-card(:class="$style.card")
      el-row
        el-col(align="middle")
          h1 Đăng nhập

      el-form(
        class="padding-top-15"
        :model="user"
      )
        el-form-item(prop="sbd")
          el-input(
            v-model="user.sbd"
            placeholder="Số báo danh"
          )

        el-form-item(prop="password")
          el-input(
            v-model="user.password"
            type="password"
            placeholder="Mật khẩu"
          )

      el-row.padding-top-15
        el-col(align="middle")
          el-button(
            :class="$style.button"
            @click="login"
            :loading="loading"
          ) Đăng nhập
</template>

<script>
  import axios from 'axios'

  export default {
    data() {
      return {
        user: {
          sbd: '',
          password: '',
        },

        loading: false,
      }
    },

    methods: {
      login() {
        this.loading = true
        return axios.post('/api/login', this.user)
          .then(({ data }) => {
            this.loading = false
            this.$router.push('/')
          }, (err) => {
            this.loading = false
          })
      },
    },
  }
</script>

<style module>
  .loginPage {
    margin: 100px auto;
  }

  .card {
    padding-left: 50px;
    padding-right: 50px;
    width: 400px;
  }

  .button {
    border-radius: 12px;
    background-color: #00ccff;
    color: white;
  }
</style>
