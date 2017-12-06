<template lang="pug">
  div(style="width: 60%;")
    student-info(
      :user.sync="user"
      @save="save"
    )

</template>

<script>
  import axios from 'axios'
  import { mapState } from 'vuex'
  import cloneDeep from 'lodash/cloneDeep'

  import StudentInfo from '@/../components/StudentInfo'

  export default {
    components: {
      StudentInfo,
    },

    data() {
      return {
        user: {},
      }
    },

    computed: {
      ...mapState({
        current_user: state => state.auth.user,
      }),
    },

    created() {
      this.$set(this, 'user', cloneDeep(this.current_user))
    },

    methods: {
      save() {
        return axios.patch('/user', {
          user: this.user,
        })
          .then(({ data }) => {
            this.$store.commit('setUser', data)
            this.$notify.success({
              title: 'Lưu thông tin thành công',
              position: 'bottom-right',
            })
          })
      },
    },
  }
</script>
