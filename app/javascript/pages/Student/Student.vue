<template lang="pug">
  div(style="width: 80%;")
    el-tabs(v-model="activeTab")
      el-tab-pane(label="Thông tin thí sinh" name="1")
        student-info(
          :user.sync="user"
          @save="save"
        )

      el-tab-pane(label="Danh sách nguyện vọng" name="2")
        student-wish()
</template>

<script>
  import axios from 'axios'
  import { mapState } from 'vuex'
  import cloneDeep from 'lodash/cloneDeep'

  import StudentInfo from '@/../components/StudentInfo'
  import StudentWish from '@/../components/StudentWish'

  export default {
    components: {
      StudentInfo,
      StudentWish,
    },

    data() {
      return {
        user: {},
        activeTab: '1',
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
