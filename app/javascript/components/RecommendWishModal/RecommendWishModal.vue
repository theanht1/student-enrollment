<template lang="pug">
  el-dialog(width="70%" title="Gợi ý nguyện vọng" :visible.sync="visible" @close="close")
    el-form(
      :model="tempWish"
      ref="form"
      label-width="200px"
      label-position="left"
      @submit.native.prevent="submit"
    )
      el-form-item(label="Chọn ngành")
        el-col(:span="24" align="right")
          el-select(
            v-model="selectedBranch"
            filterable
            style="width: 100%"
          )
            el-option(
              v-for="branch in branches"
              :key="branch"
              :label="branch"
              :value="branch"
            )

      div(v-show="unisSearch.length > 0")
        p.el-form-item__label(style="float: none; text-align: left") Danh sách gợi ý
        el-table(:data="unisSearch")
          el-table-column(
            label="Trường"
            prop="name"
            width="250"
          )
          el-table-column(
            label="Ngành"
            prop="branch"
            width="200"
          )
          el-table-column(
            label="Khối"
            prop="combination"
          )
          el-table-column(
            label="Xác suất đỗ"
            prop="prob"
          )
            template(slot-scope="scope")
              | {{ (scope.row.prob * 100).toFixed(1) }} %

          el-table-column(
            label="Thêm nguyện vọng"
          )
            template(slot-scope="scope")
              el-button(
                type="primary"
                size="small"
                @click="$emit('addWish', { university_id: scope.row.id })"
              ) Thêm


      div(align="center" style="margin-top: 20px")
        el-button(
          @click="close"
        ) Hủy

        el-button(
          type="primary"
          @click="submit"
        ) Lưu


</template>

<script>
  import axios from 'axios'
  import cloneDeep from 'lodash/cloneDeep'

  export default {
    props: {
      visibleProp: {
        type: Boolean,
        default: false,
      },
    },

    data() {
      return {
        tempWish: {},
        submitting: false,

        branches: [],
        selectedBranch: '',

        unisSearch: [],
        uniId: '',
        searching: false,
      }
    },

    computed: {
      visible: {
        get() {
          return this.visibleProp
        },

        set(value) {
          if (value === false) {
            this.$emit('close')
          }
        },
      },
    },

    watch: {
      selectedBranch() {
        this.getRecommend(this.selectedBranch)
      },
    },

    created() {
      this.getBranch()
    },

    methods: {
      submit() {
        this.$refs.form.validate((valid) => {
          this.submitting = true
          if (valid && this.type === 'add') {
            this.$emit('addWish', {
              university_id: this.uniId,
            })

            this.uniId = ''
          } else if (valid && this.type === 'edit') {
          }

          this.submitting = false
          return false
        })
      },

      close() {
        this.$emit('close')
      },

      getBranch() {
        return axios.get('/branches')
          .then(({data}) => {
            this.$set(this, 'branches', data)
          })
      },

      getRecommend(query) {
        this.searching = true
        return axios.get('/recommend', {
          params: {
            q: query,
          },
        })
          .then(({data}) => {
            this.searching = false
            this.$set(this, 'unisSearch', data)
          })
      },
    },
  }
</script>
