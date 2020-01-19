<template>
    <div id="app">
        <div class="show_center">
            <div class="message" v-for="message in messages">
                <div v-if="message.user_id == current_user_id">
                    <div class="message-right">
                        <div class="balloon-right">
                            <p>{{message.talk_content}}</p>
                        </div>
                        <div class="user-image">
                            <img :src="your_img" width="30" class="image-right">
                        </div>
                    </div>
                </div>
                <div v-else>
                    <div class="message-left">
                        <div class="user-image">
                            <img :src="my_img" width="30" height="30" class="image-left">
                        </div>
                        <div class="balloon-left">
                            <p>{{message.talk_content}}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="show_bottom">
            <textarea type="text" rows="3" cols="50" wrap="hard" v-model="input_message"></textarea>
            <button type="button" v-on:click="addNewMessage">送信</button>
        </div>
    </div>
</template>

<script>
    import axios from 'axios';

    axios.defaults.headers.common = {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };

    export default {
        data: function () {
            return {
                messages: [],
                input_message: '',
                icon: require("images/noimage.png"),
                room_id: "",
                current_user_id: "",
                my_img: "",
                your_img: ""
            }
        },
        created() {
            this.getContentTagData();
            this.fetchTalks();
        },
        methods: {
            getContentTagData() {
                const node = document.getElementById("componentsTalks");
                const props = JSON.parse(node.getAttribute("data"));
                console.log(props);
                this.room_id = props.room_id;
                this.current_user_id = props.current_user_id;
                this.my_img = props.my_img.url;
                this.your_img = props.your_img.url;
            },
            async fetchTalks() {
                console.log("from created");
                await axios.get(`${this.room_id}/talks`)
                    .then(response => {
                        this.messages = JSON.parse(response.data.talks);
                    })
            },
            addNewMessage: function () {
                console.log('addNewMessage')
                axios.post(`${this.room_id}/talks`, {
                    room_id: this.room_id,
                    talk_content: this.input_message
                })
                    .then(response => {
                        console.log(response.data.data);
                        this.messages.push(response.data.data);
                        this.input_message = "";
                    }).catch(error => {
                    console.log(error);
                });
            },
        }
    }
</script>

<style scoped>
    p {
        font-size: 2em;
        text-align: center;
    }

    .message {
        text-align: left;
    }

    .message-left {
        display: block;
    }

    .message-right {
        display: block;
        text-align: right;
    }

    .user-image {
        display: inline-block;
    }

    .image-left {
        border-radius: 25px;
        border: 1px #CCC solid;
        margin: 12px 5px 0 5px;

    }

    .image-right {
        border-radius: 25px;
        border: 1px #CCC solid;
        margin: 12px 5px 0 15px;
    }

    .balloon-left {
        display: inline-block;
        position: relative;
        margin: 10px 0 10px 15px;
        padding: 7px 15px 7px 10px;
        /*min-width: 120px;*/
        border-radius: 10px;
        max-width: 500px;
        color: #555;
        font-size: 16px;
        background: #e0edff;
        vertical-align: top;
    }

    .balloon-right {
        display: inline-block;
        position: relative;
        margin: 10px 0 10px 15px;
        padding: 7px 15px 7px 10px;
        border-radius: 10px;
        max-width: 500px;
        color: #555;
        font-size: 16px;
        background: #E9FFA5;
        vertical-align: top;
    }

    .balloon-left:before {
        content: "";
        position: absolute;
        top: 15px;
        left: -30px;
        margin-top: -15px;
        border: 15px solid transparent;
        border-right: 30px solid #e0edff;
    }

    .balloon-right:before {
        content: "";
        position: absolute;
        top: 15px;
        right: -30px;
        margin-top: -15px;
        border: 15px solid transparent;
        border-left: 30px solid #E9FFA5;
    }

    .balloon-left p {
        font-size: 16px;
        margin: 0 0 0 5px;
        padding: 0;
        text-align: left;
    }

    .balloon-right p {
        font-size: 16px;
        margin: 0 5px 0 0;
        padding: 0;
        text-align: left;
    }
</style>
