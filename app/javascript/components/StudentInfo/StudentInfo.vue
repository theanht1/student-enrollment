<template lang="pug">
  el-form(:model="user")
    el-form-item(label="Tên")
      el-input(v-model="user.name" :disabled="true")

    el-form-item(label="Số báo danh")
      el-input(v-model="user.sbd" :disabled="true")

    el-form-item(label="Ngày sinh")
      el-input(v-model="user.birthday" :disabled="true")

</template>

<script>
  export default {
    props: {
      user: {
        type: Object,
        required: true,
      },
    },
  }
</script>
