<template lang="pug">
  el-dialog(width="60%" title="Nội dung nguyện vọng" :visible.sync="visible" @close="close")
    el-form(
      :model="tempWish"
      ref="form"
      label-width="200px"
      label-position="left"
      @submit.native.prevent="submit"
    )
      el-form-item(label="Trường")
        el-col(:span="24" align="right")
          el-select(
            v-model="uniCode"
            filterable
            remote
            :remote-method="getUniversities"
            :loading="searching"
            style="width: 100%"
          )
            el-option(
              v-for="uni in unisSearch"
              :key="uni.code"
              :label="`${uni.code} - ${uni.name}`"
              :value="uni.code"
            )

      el-form-item(label="Ngành")
        el-col(:span="24" align="right")
          el-select(
            v-model="branchId"
            style="width: 100%"
          )
            el-option(
              v-for="branch in branches"
              :key="branch.id"
              :label="branch.branch"
              :value="branch.id"
            )

      el-form-item(label="Tổ hợp môn")
        el-col(:span="24" align="right")
          el-select(
            v-model="comb"
            style="width: 100%"
          )
            el-option(
              v-for="com in selectedBranchCombs"
              :key="com"
              :label="com"
              :value="com"
            )

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

      wish: {
        type: Object,
        default: () => ({}),
      },

      type: {
        type: String,
        default: 'add',
      },
    },

    data() {
      return {
        tempWish: cloneDeep(this.wish),
        submitting: false,

        unisSearch: [],
        uniCode: '',
        searching: false,

        branchId: '',
        branches: [],
        comb: '',
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

      selectedBranchCombs() {
        if (!this.branchId) {
          return []
        }

        return this.branches.find(b => b.id === this.branchId).combinations
      },
    },

    watch: {
      wish() {
        this.$set(this, 'tempWish', cloneDeep(this.wish))
      },

      type() {
        this.$set(this, 'tempWish', cloneDeep(this.wish))
      },

      uniCode() {
        if (this.uniCode.length > 0) {
          this.getBranches()
        }
      },

      branchId() {
        this.$set(this, 'comb', this.selectedBranchCombs[0])
      },
    },

    methods: {
      submit() {
        this.$refs.form.validate((valid) => {
          this.submitting = true
          if (valid && this.type === 'add') {
            this.$emit('addWish', {
              university_id: this.branchId,
              combination: this.comb,
            })

            this.uniCode = ''
            this.comb = ''
            this.unisSearch = []
            this.branches = []
            this.branchId = ''
          } else if (valid && this.type === 'edit') {
          }

          this.submitting = false
          return false
        })
      },

      close() {
        this.$emit('close')
      },

      getUniversities(query) {
        this.searching = true
        return axios.get('/search-universities', {
          params: {
            q: query,
          },
        })
          .then(({data}) => {
            this.searching = false
            this.$set(this, 'unisSearch', data.universities)
          })
      },

      getBranches() {
        return axios.get(`/universities/${this.uniCode}/branches`)
          .then(({data}) => {
            this.$set(this, 'branches', data)
          })
      },
    },
  }
</script>
