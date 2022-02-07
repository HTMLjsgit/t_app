$(function () {
  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  var dataBoxInd = new DataTransfer();

  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[id="img-file"]')
  var file_field_ind = document.querySelector('input[id="img-file-ind"]')

  //fileが選択された時に発火するイベント
  $(document).on('change', 'input[id="img-file"]', function () {
    //選択したfileのオブジェクトをpropで取得
    var files = $('input[id="img-file"]').prop('files')[0];
    console.log(files)
    $.each(this.files, function (i, file) {
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var num = $('.item-image').length + 1 + i
      console.log(num)
      //画像が10枚になったら超えたらドロップボックスを削除する
      if (num >= 10) {
        $('#image-box__container').css('display', 'none')
      } else {
        $('#image-box__container').css('display', 'block')
      }
      //読み込みが完了すると、srcにfileのURLを格納
      if (num <= 10) {
        var fileReader = new FileReader();

        //DataTransferオブジェクトに対して、fileを追加
        dataBox.items.add(file)
        //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
        file_field.files = dataBox.files

        fileReader.readAsDataURL(file);

        fileReader.onloadend = function () {
          var src = fileReader.result
          var html = `<div class='item-image item_image_${num - 1}' data-image="${file.name}" id="${num - 1}" style="margin: 5px;">
                        <img src=${src} class="item1" >
                        <div>
                          <img src='/assets/white.jpeg' width="20" height="20"  class="item-image__operetion--delete" >
                        </div>
                      </div>`
          //image_box__container要素の前にhtmlを差し込む
          $('#image-box__container').before(html);
        };
        //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
        $('#image-box__container').attr('class', `item-num-${num}`)
      }
    });
  });

  $(document).on('change', 'input[id="img-file-ind"]', function () {
    //選択したfileのオブジェクトをpropで取得
    var files = $('input[id="img-file-ind"]').prop('files')[0];

    $.each(this.files, function (i, file) {
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();
      // console.log(this.files)

      //DataTransferオブジェクトに対して、fileを追加
      dataBoxInd.items.add(files)
      // console.log(dataBox.files)
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
      file_field_ind.files = dataBoxInd.files

      var num = $('.item-image-ind').length + 1 + i
      console.log(num)
      fileReader.readAsDataURL(file);
      //画像が10枚になったら超えたらドロップボックスを削除する
      if (num == 1) {
        $('#image-box__container1').css('display', 'none')
      }
      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function () {
        var src = fileReader.result
        var html = `<div class='item-image-ind item_image_ind_${num - 1}' data-image="${file.name}" id="${num - 1}" >
                      <img src=${src} class="item-ind" width="120" height="180"; >
                      <div>
                        <img src='/assets/white.jpeg' width="20" height="20"  class="item-image__operetion--delete-ind" >
                      </div>
                    </div>`
        //image_box__container要素の前にhtmlを差し込む
        $('#image-box__container1').before(html);
      };
      //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
      $('#image-box__container1').attr('class', `item-num-${num}`)
    });
  });

  $(document).on("click", '.item-image__operetion--delete', function () {
    //削除を押されたプレビュー要素を取
    console.log("afafeae")
    var target_image = $(this).parent().parent()
    //削除を押されたプレビューimageのfile名を取得
    var target_name = $(target_image).data('image')
    var target_id = $(target_image).attr("id")
    console.log(target_name)
    console.log(target_id)
    //プレビューがひとつだけの場合、file_fieldをクリア
    if (file_field.files.length == 1) {
      //inputタグに入ったファイルを削除
      $('input[type=file]').val(null)
      dataBox.clearData();
    } else {
      //プレビューが複数の場合
      var deleted = file_field.files.length
      $.each(file_field.files, function (i, input) {
        //削除を押された要素と一致した時、index番号に基づいてdataBoxに格納された要素を削除する
        console.log(i)

        if (input.name == target_name && i == target_id) {
          console.log(target_id)
          console.log(target_name)
          dataBox.items.remove(i)
          deleted = i
        }
        if (i >= deleted) {
          $(`.item_image_${i}`).attr({ id: `${i - 1}`, class: `item-image item_image_${i - 1}` });
        }
      })
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に再度代入
      file_field.files = dataBox.files

    }
    //プレビューを削除
    target_image.remove()
    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    var num = $('.item-image').length
    $('#image-box__container').show()
    $('#image-box__container').attr('class', `item-num-${num}`)
  })

  $(document).on("click", '.item-image__operetion--delete-ind', function () {
    //削除を押されたプレビュー要素を取
    console.log("afafeae")
    var target_image = $(this).parent().parent()
    //削除を押されたプレビューimageのfile名を取得
    var target_name = $(target_image).data('image')
    var target_id = $(target_image).attr("id")
    console.log(target_name)
    console.log(target_id)
    //プレビューがひとつだけの場合、file_fieldをクリア
    if (file_field_ind.files.length == 1) {
      //inputタグに入ったファイルを削除
      // $('input[type=file]').val(null)
      dataBoxInd.clearData();
    } else {
      //プレビューが複数の場合
      var deleted = file_field_ind.files.length
      $.each(file_field_ind.files, function (i, input) {
        //削除を押された要素と一致した時、index番号に基づいてdataBoxに格納された要素を削除する
        console.log(i)

        if (input.name == target_name && i == target_id) {
          console.log(target_id)
          console.log(target_name)
          dataBoxInd.items.remove(i)
          deleted = i
        }
        if (i >= deleted) {
          $(`.item_image_ind_${i}`).attr({ id: `${i - 1}`, class: `item-image-ind item_image_ind_${i - 1}` });
        }
      })
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に再度代入
      file_field_ind.files = dataBoxInd.files

    }
    //プレビューを削除
    target_image.remove()
    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    var num = $('.item-image-ind').length
    $('#image-box__container1').show()
    $('#image-box__container1').attr('class', `item-num-${num}`)
  })
});
