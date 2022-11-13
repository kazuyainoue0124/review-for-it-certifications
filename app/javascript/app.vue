<template>
  <div id="app">
    <table>
      <tbody>
        <tr>
          <th>name</th>
          <th>title</th>
          <th>updated_at</th>
        </tr>
        <tr v-for="p in posts" :key="p.id">
          <td>{{ p.name }}</td>
          <td>{{ p.title }}</td>
          <td>{{ p.updated_at }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      posts: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/posts.json')
      .then(response => (this.posts = response.data))
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
