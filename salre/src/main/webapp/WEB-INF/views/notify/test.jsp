<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>알림 전송</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body>
        <h1>알림 전송 테스트 페이지</h1>
        <h2>(Deprecated)</h2>
        <div class="target-form">
            <input type="number" name="target" placeholder="대상 입력" />
            <button id="send">알림 보내기</button>
        </div>
        <script>
            // 알림 보내기
            $('#send').click(function () {
                // 알림 대상 입력
                const user_id = $("input[name='target']").val();
                // 알림 내용 입력
                const notify_content = `\${user_id}님<br>송금 알림입니다.`;
                // 알림 클릭 시 이동할 URL
                const notify_url = "${pageContext.request.contextPath}/";

                $.ajax({
                    type: "POST",
                    url: `${pageContext.request.contextPath}/notify/send`,
                    contentType: "application/json",
                    data: JSON.stringify({
                        user_id: user_id,
                        notify_content: notify_content,
                        notify_url: notify_url
                    }),
                    success: function () {
                        console.log("알림 전송 성공");
                    },
                    error: function () {
                        console.error("알림 전송 오류");
                    }
                });
            });
        </script>
    </body>

    </html>