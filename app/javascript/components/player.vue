<template>
  <div ref="container" class="player-container">
    <video id="player"
           playsinline
           controls
           >
    </video>
    <div class="actions top right">
      <button @click="close" class="action"><i class="fas fa-times"></i></button>
    </div>
  </div>
</template>

<script>
import Plyr from 'plyr';
import Vue from 'vue';

export const state = Vue.observable({
  source: null,
});

export default {
  computed: {
    source() {
      return state.source;
    },
  },
  mounted() {
    const player = new Plyr('#player', {
      disableContextMenu: false,
      debug: true,
      controls: [
        'play-large', 'play', 'progress', 'current-time', 'mute', 'volume', 'captions', 'settings', 'pip', 'airplay', 'fullscreen'
      ],
    });
    player.on('canplay',        this.updateAspectRatio);
    player.on('exitfullscreen', this.updateAspectRatio);
    window.player = player;
  },
  methods: {
    playSource(source) {
      this.hidePlayer();
      player.poster = this.source.thumbnailUrl;
      player.source = {
        type: 'video',
        sources: [
          {
            src: this.source.lastDownload.downloadUrl,
            type: 'video/mp4'
          },
        ],
      };
      this.showPlayer();
      player.play();
    },
    showPlayer() {
      this.$refs.container.style.display = "block";
    },
    hidePlayer() {
      this.$refs.container.style.display = "none";
    },
    updateAspectRatio() {
      let ratio = player.ratio;
      let height = null;
      if (ratio == null) {
        height = 53;
      } else {
        let dims = ratio
            .split(":")
            .map(s => parseInt(s))
        height = dims[1] / dims[0] * this.$refs.container.clientWidth;
      }
      this.$refs.container.style.height = height + "px";
    },
    close() {
      player.stop();
      this.hidePlayer();
    },
  },
  watch: {
    'source': {
      handler(val, oldVal) {
        this.playSource(val);
      }
    },
  },
}
</script>

<style scoped>
</style>
