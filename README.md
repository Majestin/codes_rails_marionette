* Category 추가
Category의 Controller, Model을 생성 후
Backbone Entitiy, Controller(List), Views 생성
간단히 route 정리 후 실행확인 후 
CSS 조정 

* Tag 추가
Category와 비슷..


* Snipeets 추가
Category를 References하는 Model을 생성하고
사용자가 처음 접속 했을 때 마지막으로 선택한 Category SELECTED 활성화 후
해당 Snippets가 보이게 끔 

-- Default 는 All Snippets가 자동으로 선택이 되고 해당 Snippets 보이고 Updated 내림차순이 기본 정렬

0. Snippet 모델 생성
1. Snippets 컨트롤러 생성
2. Test Data 생성

apps/box/box_center/
1. app.js
2. controller 
3. view
4. templates

rounte 설정도 대충해주고
api controller에 category 가져오는 get_snippets_by_id  함수 만듬

Snippets.Controller 생성 
출력 확인
CSS Hover 생성 (마우스올렸을때 백그라운드 변경 확인)


자동으로 Snippet 선택 되지 않고 Detail영역엔 EmptyView를 생성하여 뿌려준다.


2013.09.07

Category 추가되면 자동으로 선택되게 (SELECTED) 하고 해당 카테고리의 스니펫 불러오고 

삭제되면 

2013.09.08
Snippet 오른쪽 클릭, 클릭 트리거 활성화

Route History 에러 수정 (마음대로 왔다갔다 가능)
Cateogry 삭제하면 all로 이동 , 추가하면 해당 Category로 이동


** Category Controller Rerender 하는 방법 찾기..


2013.09.09

Category 선택할때마다 Snippet Detail 영역 지워지게 한다.
http://0.0.0.0:3000/#box/snippet/17 <- 이렇게 들어왔을때 카테고리만 생김
Snippets와, Detail이 활성화 되어야함
Snippet Id로 Category_id가져와서 category_id로 snippets들 가져와야함..

2013.09.11
카테고리 클릭했을때 Detail 영역에 EmptyView 생성,
새로운 UI 탑재!

2013.09.12
http://0.0.0.0:3000/#box/snippet/17 <- 이렇게 들어왔을때 카테고리 로드 후 ... (URL검사식은 이게 괜찮은가.. 고민해봐야함)
XXXX카테고리는 all을 가리키고 해당 snippet을 찾음..

showSnippetById에서 Snippet id로 Snippet Entity를 가져옴
그 Snippet의 Category_id를 가져와서 
@getSnippetsByCategoryid 함수를 실행시킴..
category_id가 0일땐 all인 경우이므로 
@getSnippets 을 실행시킴..

어떠한 이벤트가 실행됬을때 실행되야할 트리거들을 만들자!!!!
ex) url로 들어왔을때 selected 활성화 등

# 1. All snippets (전체 snippet 개수)
# 1-1. Snippet 갯수 변경 될때마다 Cateogry 옆의 Badge 변경
# 1-2. Snippet 추가시 뱃지에있는 개수바뀜 처리

# 1-2. 폴더 바뀔때마다 Center Header에 이름 변경 
# 2. #box/:id (이런식으로 들어왔을때 Category SELECTED 활성화)

# 3. Snippet 추가시 자동 렌더링 Detail 뷰 렌더링
3-1. 스크롤 높이 등 CSS 잔버그 처리


# 5. $box/snippet:id (이런식으로 들어왔을때 Cateogry, Snippet SELECTED 활성화)
6. Drag, Drop 해서 Snippet을 다른 폴더로 옮기게 할 수 있게..
6-1. Drag, Drop 해서 Folder도 순서정할 수 있게 해야함..
7. 폴더도 Nesting 관계가 이루어지도록 해야함.. parent가 없을때만 안에 들어갈 수 있게


tag 추가

http://0.0.0.0:3000/#box/tag/:id 

id는 tag_id이며 tag에 속해있는 모든 snippet들을 가져오게함

http://0.0.0.0:3000/#box/tag/snippet/:id 



불러오게해야 함


2013.09.15
Snippet Detail Title 수정 가능.
snippet를 들어왔을때 modelChanged가 안먹히는 현상 수정..
아마 같은 Snippet을 공유 안하고 있기 때문인것 같음.

클릭 했을때 Snippet을 넘겨주고 이건 해당 스니펫을 인위적으로 찾아서 넘겨주기 때문에..
http://0.0.0.0:3000/#box/snippet/403 이런식의 URL로 들어 왔을때 
SnippetsView의 @.collection에서 snippet을 찾은 다음 넘겨주도록 해보자..(했음..)

Tag 추가하자..

카테고리 밑에 추가될 전체 테그리스트 ..음 
태그 전체적으로 고쳐야함
쉼표 눌렀을때 태그가 안 먹는 버그..등

# 디테일 휴지통 버튼 활성
# 


# 태그 추가..
# URL접속시 SELECTED 활성화

# 태그 추가 시 Tag메뉴에도 변화가 있어야함





