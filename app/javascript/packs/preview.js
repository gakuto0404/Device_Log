if (document.URL.match(/new/)){ //レビュー投稿プレビュー
  document.addEventListener('DOMContentLoaded', () => {

    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.id = 'review-img';
      blobImage.setAttribute('class', 'new-img')
      blobImage.setAttribute('src', blob);

      imageElement.appendChild(blobImage);
    };

    document.getElementById('review_image').addEventListener('change', (e) =>{
      const imageContent = document.getElementById('review-img');
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}

if (document.URL.match(/edit/)){ //レビュー編集プレビュー
  document.addEventListener('DOMContentLoaded', () => {

    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.id = 'review-img';
      blobImage.setAttribute('class', 'new-img')
      blobImage.setAttribute('src', blob);

      imageElement.appendChild(blobImage);
    };

    document.getElementById('review_image').addEventListener('change', (e) =>{
      const imageContent = document.getElementById('review-img');
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}

if (document.URL.match(/edit/)){ //ユーザー編集プレビュー
  document.addEventListener('DOMContentLoaded', () => {

    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img');
      blobImage.id = 'user-img';
      blobImage.setAttribute('class', 'new-img')
      blobImage.setAttribute('src', blob);

      imageElement.appendChild(blobImage);
    };

    document.getElementById('user_profile_image').addEventListener('change', (e) =>{
      const imageContent = document.getElementById('user-img');
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}