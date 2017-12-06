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
        el-table(
          :data="wishes"
          :stripe="true"
        )
          el-table-column(
            type="index"
          )
          el-table-column(
            prop="university.code"
            label="Mã trường"
            width="100"
          )
          el-table-column(
            prop="university.name"
            label="Trường"
            width="250"
          )
          el-table-column(
            prop="university.branch"
            label="Ngành"
            width="200"
          )
          el-table-column(
            prop="university.combinations"
            label="Khối"
            :formatter="combinationsFormat"
          )
          el-table-column(
            prop="university.amount_2017"
            label="Chỉ tiêu 2017"
          )
          el-table-column(
            label="Xóa"
          )
            template(slot-scope="scope")
              el-button(
                size="small"
                type="danger"
                @click="deleteWish(scope.$index, scope.row)"
              ) Xóa

        el-row(:gutter="10" style="margin-top: 30px;")
          el-col(:span="12")
            el-select(
              v-model="uniId"
              filterable
              remote
              :remote-method="getUni"
              :loading="searching"
              style="width: 100%"
            )
              el-option(
                v-for="uni in unisSearch"
                :key="uni.id"
                :label="`${uni.branch} - ${uni.name}`"
                :value="uni.id"
              )
          el-col(:span="4")
            el-button(
              type="primary"
              size="small"
              @click="addWishes"
            ) Thêm nguyện vọng

</template>

<script>
  import axios from 'axios'
  import { mapState } from 'vuex'
  import cloneDeep from 'lodash/cloneDeep'

  export default {
    data() {
      return {
        user: {},
        wishes: [],
        unisSearch: [],
        uniId: '',
        activeTab: '1',
        searching: false,
      }
    },

    computed: {
      ...mapState({
        current_user: state => state.auth.user,
      }),
    },

    created() {
      this.$set(this, 'user', cloneDeep(this.current_user))
      this.getData()
    },

    methods: {
      getData() {
        this.getWishes()
      },

      getWishes() {
        return axios.get('/wishes')
          .then(({ data }) => {
            this.$set(this, 'wishes', data)
          })
      },

      addWishes() {
        return axios.post('/wishes', {
          university_id: this.uniId,
        })
          .then(() => {
            this.uniId = ''
            this.unisSearch = []

            this.$notify.success({
              title: 'Đăng kí nguyện vọng thành công',
              position: 'bottom-right',
            })
            this.getWishes()
          })
      },

      deleteWish(index, wish) {
        this.$confirm('Bạn có muốn xóa nguyện vọng này không?', 'Xóa nguyện vọng', {
          confirmButtonText: 'OK',
          cancelButtonText: 'Hủy',
          type: 'danger',
        })
          .then(() => {
            axios.delete(`/wishes/${wish.id}`)
              .then(() => {
                this.wishes.splice(index, 1)
                this.$notify.success({
                  title: 'Xóa nguyện vọng thành công',
                  position: 'bottom-right',
                })
              })
          })
      },

      getUni(query) {
        this.searching = true
        return axios.get('/search-universities', {
          params: {
            q: query,
          },
        })
          .then(({data}) => {
            this.searching = false
            this.$set(this, 'unisSearch', data)
          })
      },

      combinationsFormat(row, col, combs) {
        return combs.join(', ')
      },
    },
  }
</script>
