<template lang="pug">
  div(style="width: 80%")
    el-form(:inline="true" size="small")
      el-form-item(label="Tên trường/ngành")
        el-input(v-model="search")

    el-table(
      v-loading="loading"
      :data="unis"
      :stripe="true"
    )
      el-table-column(
        type="index"
      )
      el-table-column(
        prop="code"
        label="Mã trường"
        width="100"
      )
      el-table-column(
        prop="name"
        label="Trường"
        width="250"
      )
      el-table-column(
        prop="branch"
        label="Ngành"
        width="200"
      )
      el-table-column(
        prop="combination"
        label="Khối"
      )
      el-table-column(
        prop="score_2016"
        label="Điểm chuẩn 2016"
      )
      el-table-column(
        prop="amount_2017"
        label="Chỉ tiêu 2017"
      )
      el-table-column(
        prop="threshold_score"
        label="Ngưỡng nộp hồ sơ"
      )

    el-pagination(
      background
      layout="prev, pager, next"
      :page-size="perPage"
      :current-page.sync="page"
      :total="total"
      style="margin-top: 10px"
    )

</template>

<script>
  import axios from 'axios'

  export default {
    data() {
      return {
        unis: [],
        total: 0,

        search: '',
        perPage: 20,
        page: 1,
        loading: false,
      }
    },

    created() {
      this.getData()
    },

    watch: {
      page() {
        this.getUniversities()
      },

      search() {
        this.getUniversities()
      },
    },

    methods: {
      getData() {
        this.getUniversities()
      },

      getUniversities() {
        this.loading = true
        return axios.get('/universities', {
          params: {
            q: this.search,
            page: this.page,
            per: this.perPage,
          },
        })
          .then(({ data }) => {
            this.$set(this, 'unis', data.universities)
            this.$set(this, 'total', data.total)

            this.loading = false
          })
      },

      combinationsFormat(row, col, combs) {
        return combs.join(', ')
      },
    },
  }
</script>
