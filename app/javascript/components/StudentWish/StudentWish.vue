<template lang="pug">
  div
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
        prop="combination"
        label="Khối"
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

    div(style="margin-top: 30px;")
      el-button(
        type="primary"
        @click="showWishModal = true"
      ) Thêm nguyện vọng

      wish-modal(
        :visible-prop="showWishModal"
        type="add"
        @close="showWishModal = false"
        @addWish="addWish"
      )

</template>

<script>
  import axios from 'axios'

  import WishModal from '../WishModal'

  export default {
    components: { WishModal },

    data() {
      return {
        wishes: [],

        showWishModal: false,
      }
    },

    created() {
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

      addWish({ university_id, combination}) {
        return axios.post('/wishes', {
          university_id,
          combination,
        })
          .then(() => {
            this.$notify.success({
              title: 'Đăng kí nguyện vọng thành công',
              position: 'bottom-right',
            })
            this.getWishes()
            this.showWishModal = false
          })
      },
      combinationsFormat(row, col, combs) {
        return combs.join(', ')
      },
    },
  }
</script>
