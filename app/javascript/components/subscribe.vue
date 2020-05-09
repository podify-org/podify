<template>
<div class="subscribe">
  Subscribe to {{ feed.name }}: {{ feed.rssUrl }}
</div>
</template>

<script>
export default {
  props: ['feed'],
}
</script>
