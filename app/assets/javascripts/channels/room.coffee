App.room = App.cable.subscriptions.create "RoomChannel",
  connected: -> # 接続特に何もしない
  disconnected: -> # 接続解除特に何もしない
  received: (data) ->
    # サーバーサイドから値を受け取る（メッセージ、投稿者のユーザID、投稿者の画像、部屋ID）
    msg = '';
    id = '';
    img = '';
    dt_arr = data["message"];

    now = new Date();
    Year = now.getFullYear();
    Month = ('0' + String(now.getMonth()+1)).slice(-2);
    DateStr = ('0' + String(now.getDate())).slice(-2);
    Hour = now.getHours();
    Min = now.getMinutes();
    time = Year + "-" + Month + "-" + DateStr + " " + Hour + ":" + Min;

    if dt_arr[0] != undefined
      msg = dt_arr[0];
    if dt_arr[1] != undefined
      id = dt_arr[1];
    if dt_arr[2] != undefined
      img = dt_arr[2];
    if id == $("#my_id").val() # 自分の投稿を追加
      if img == '' # 画像がない場合
        $('#posts').append('<div style="text-align: right;margin: 8px;"><span class="message my">'+msg+'</span><p class="chat_time my">'+time+'</p></div>');
      else
        $('#posts').append('<div style="text-align: right;margin: 8px;"><span class="message my">'+msg+'</span><p class="chat_time my">'+time+'</p></div>');
    else # 相手の投稿を追加
      if img == '' # 画像がない場合
        $('#posts').append('<div style="text-align: left;margin: 8px;"><a href="/users/'+id+'"><img class="room_avater_image" src="/blank-profile-picture-973460_640.png"></a><span class="message etc">'+msg+'</span><p class="chat_time">'+time+'</p></div>');
      else
        $('#posts').append('<div style="text-align: left;margin: 8px;"><a href="/users/'+id+'"><img class="room_avater_image" src="'+img+'"></a><span class="message etc">'+msg+'</span><p class="chat_time">'+time+'</p></div>');

  speak: (message)->
    @perform 'speak', message: message

# Enterキー押下時
$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return キーのキーコードが13
    # サーバーサイドのspeakアクションにmessageパラメータを渡す（メッセージ、投稿者のユーザID、投稿者の画像、部屋ID）
    App.room.speak [event.target.value, $('[data-user]').attr('data-user'), $('[data-img]').attr('data-img'), $('[data-room]').attr('data-room')]
    event.target.value = '' # メッセージのリセット
    event.preventDefault() # 以降のイベントを無効（ここでkeypressイベント処理終了）
