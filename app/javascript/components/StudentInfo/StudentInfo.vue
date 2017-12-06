<template lang="pug">
  el-form(:model="user")
    el-form-item(label="Tên")
      el-input(v-model="user.name" :disabled="true")

    el-form-item(label="Số báo danh")
      el-input(v-model="user.sbd" :disabled="true")

    el-form-item(label="Ngày sinh")
      el-input(v-model="user.birthday" :disabled="true")

    div
      p.el-form-item__label(style="float: none; text-align: left") Điểm thi
      el-row(:gutter="30")
        el-col(:span="12")
          el-table(:data="user.scores")
            el-table-column(
              label="Môn"
              prop="subject_id"
              :formatter="subName"
            )
            el-table-column(
              label="Điểm"
              prop="score"
            )

            el-table-column(
              label="Xóa"
            )
              template(slot-scope="scope")
                el-button(
                  type="danger"
                  size="small"
                  icon="el-icon-close"
                  @click="deleteScore(scope.$index)"
                )

        el-col(:span="12")
          el-row(:gutter="20")
            el-col(:span="12")
              el-select(
                v-model="newSubjectId"
                placeholder="Chọn môn thi"
              )
                el-option(
                  v-for="sub in subjects"
                  :key="sub.id"
                  :value="sub.id"
                  :label="sub.name"
                )
            el-col(:span="12")
              el-input-number(
                v-model="newScore"
                controls-position="right"
                :step="0.2"
                :min="0"
                :max="10"
                placeholder="Nhập điểm thi"
              )

          el-row(style="margin-top: 10px; padding-right: 35px")
            div(align="right")
              el-button(
                type="primary"
                size="small"
                icon="el-icon-plus"
                @click="addScore"
              ) Thêm điểm thi

    div(align="center" style="margin-top: 20px")
      el-button(
        type="primary"
        @click="$emit('save')"
      ) Lưu thông tin

</template>

<script>
  const SUBJECTS = [
    { id: 1, name: "Toán" },
    { id: 2, name: "Vật Lý" },
    { id: 3, name: "Hóa Học" },
    { id: 4, name: "Tiếng Anh" },
    { id: 5, name: "Sinh Học" },
    { id: 6, name: "Ngữ Văn" },
    { id: 7, name: "Lịch Sử" },
    { id: 8, name: "Địa Lý" },
    { id: 9, name: "Tiếng Nga" },
    { id: 10, name: "Tiếng Pháp" },
    { id: 11, name: "Tiếng Trung" },
    { id: 12, name: "Tiếng Đức" },
    { id: 13, name: "Tiếng Nhật" },
    { id: 14, name: "Năng Khiếu Vẽ NT 1" },
    { id: 15, name: "Năng Khiếu Vẽ NT 2" },
    { id: 16, name: "Vẽ Mỹ Thuật" },
    { id: 17, name: "Năng Khiếu Âm Nhạc 1" },
    { id: 18, name: "Năng Khiếu Âm Nhạc 2" },
    { id: 19, name: "Đọc Diễn Cảm" },
    { id: 20, name: "Hát" },
    { id: 21, name: "Năng Khiếu THTT" },
    { id: 22, name: "Năng Khiếu SKDA 1" },
    { id: 23, name: "Năng Khiếu SKDA 2" },
    { id: 24, name: "Năng Khiếu Báo Chí" },
    { id: 25, name: "Kỹ Thuật Nghề" },
    { id: 26, name: "Khoa Học Xã Hội" },
    { id: 27, name: "Khoa Học Tự Nhiên" },
    { id: 28, name: "GDCD" },
  ]

  export default {
    props: {
      user: {
        type: Object,
        required: true,
      },
    },

    data() {
      return {
        newSubjectId: '',
        newScore: 0,
      }
    },

    computed: {
      subjects() {
        return SUBJECTS.filter((sub) => {
          return this.user.scores.every((score) => score.subject_id !== sub.id)
        })
      },
    },

    methods: {
      addScore() {
        this.user.scores.push({
          subject_id: this.newSubjectId,
          score: this.newScore,
        })

        this.newSubjectId = '',
        this.newScore = 0
      },

      deleteScore(index) {
        this.user.scores.splice(index, 1)
      },

      subName(row, col, subject_id) {
        return this.subjectName(subject_id)
      },

      subjectName(id) {
        return SUBJECTS.find((sub) => sub.id === id).name
      },
    },
  }
</script>
