<template lang="pug">
  div(style="width: 60%;")
    el-tabs(v-model="activeTab")
      el-tab-pane(label="Thông tin thí sinh" name="1")
        student-info(:user.sync="user")

      el-tab-pane(label="Danh sách nguyện vọng" name="2")
        student-wish()
</template>

<script>
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
  }
</script>
