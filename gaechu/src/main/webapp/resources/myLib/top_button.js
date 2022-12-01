'use strict';

const scTop = document.querySelector('.scrollTop');

document.addEventListener('scroll', () => {
    if (scrollY > window.innerHeight / 3) {
        scTop.classList.add('visible');
        //클래스 넣을때 쓰는것 classlist.add
    } else {
        scTop.classList.remove('visible');
    }
});

//존재하지 않는 가상 클래스를 만들고 css를 만듬.
//조건을 걸었을때 class명을 추가해주고  다중클래스 가능
//개발자 도구 확인해보면 div class뒤에 글자 visible이 생성됨
// css 적용 완료

scTop.addEventListener('click', () => {
    var timeout = setInterval(() => {
        window.scrollBy(scrollX, -5)
        if (scrollY <= 0) {
            clearInterval(timeout)
        }
    }, 5)
})