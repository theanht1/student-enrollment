<template lang="pug">
  div(style="width: 60%;")
    el-tabs(v-model="activeTab")
      el-tab-pane(label="Thông tin thí sinh" name="1")
        el-form(:model="user")
          el-form-item(label="Tên")
            el-input(v-model="user.name" :disabled="true")

          el-form-item(label="Số báo danh")
            el-input(v-model="user.sbd" :disabled="true")

          el-form-item(label="Ngày sinh")
            el-input(v-model="user.birthday" :disabled="true")

      el-tab-pane(label="Danh sách nguyện vọng" name="2")
        | Éo có

</template>

<script>
  import { mapState } from 'vuex'
  import cloneDeep from 'lodash/cloneDeep'

  export default {
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
