<template lang="pug">
  div(style="width: 85%")
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
        prop="university.combination"
        label="Khối"
      )
      el-table-column(
        prop="university.amount_2017"
        label="Chỉ tiêu 2017"
      )
      el-table-column(
        prop="score"
        label="Điểm thi"
      )
      el-table-column(
        label="Xác suất đỗ"
      )
        template(slot-scope="scope")
          | {{ (scope.row.prob * 100).toFixed(1) }} %

      el-table-column(
        width="200"
      )
        template(slot-scope="scope")
          el-button(
            size="small"
            type="danger"
            @click="deleteWish(scope.$index, scope.row)"
          ) Xóa

          el-button(
            v-show="scope.$index > 0"
            size="small"
            icon="el-icon-arrow-up"
            @click="moveUp(scope.$index)"
          )

          el-button(
            v-show="scope.$index < wishes.length - 1"
            size="small"
            icon="el-icon-arrow-down"
            @click="moveDown(scope.$index)"
          )

    div(style="margin-top: 30px;")
      el-button(
        type="primary"
        @click="showWishModal = true"
      ) Thêm nguyện vọng

      el-button(
        type="primary"
        @click="showRecommendModal = true"
      ) Gợi ý nguyện vọng

      recommend-wish-modal(
        :visible-prop="showRecommendModal"
        @close="showRecommendModal = false"
        @addWish="addWish"
      )

      wish-modal(
        :visible-prop="showWishModal"
        type="add"
        @close="showWishModal = false"
        @addWish="addWish"
      )

</template>

<script>
  import axios from 'axios'

  import WishModal from '@/../components/WishModal'
  import RecommendWishModal from '@/../components/RecommendWishModal'

  export default {
    components: { WishModal, RecommendWishModal },

    data() {
      return {
        wishes: [],

        showWishModal: false,
        showRecommendModal: false,
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

      addWish({ university_id }) {
        return axios.post('/wishes', {
          university_id,
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

      changeOrder() {
        const wishIds = this.wishes.map((wish) => wish.id)

        return axios.patch('/order', {
          wishes: wishIds,
        })
      },

      moveUp(index) {
        this.wishes.splice(index - 1, 0, this.wishes.splice(index,1)[0]);

        this.changeOrder()
      },

      moveDown(index) {
        this.wishes.splice(index + 1, 0, this.wishes.splice(index,1)[0]);

        this.changeOrder()
      },
    },
  }
</script>
