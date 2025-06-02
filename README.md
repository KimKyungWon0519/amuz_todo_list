# Amuz Todo List
## 주요 기능
- 할 일(Todo) 추가, 수정, 삭제
- 태그(Tag)로 할 일 분류 및 관리
- 할 일별 이미지 첨부 및 미리보기
- 마감일(Due Date) 설정 및 완료 상태 표시
- 임시 저장/불러오기 기능 지원
- Riverpod 기반 상태 관리
- Drift 기반 로컬 데이터베이스 사용
- GoRouter를 활용한 네비게이션

## Flutter 버전 및 지원 플랫폼
- 최소 Flutter SDK: 3.29.x 이상
- 지원 플랫폼: Android

## 프로젝트 구조
- `lib/` : 주요 Flutter 소스 코드
  - `core/` : 라우트, 상수 등 핵심 로직
  - `data/` : 데이터 소스, 테이블, 리포지토리 구현
  - `domain/` : 도메인 모델 및 추상 리포지토리
  - `presentation/` : UI, 페이지, 위젯, 리버팟 상태 등

## Drift(LocalDatabase) 테이블 구조
- **Todos** (할 일 데이터)
  - `id` (Int, PK, auto increment)
  - `title` (String, 최대 길이 100자)
  - `isDone` (Bool, 기본값 false)
  - `createDate` (DateTime, 생성일)
  - `updateDate` (DateTime, 수정일, nullable)
  - `dueDate` (DateTime, 마감일)
- **Tags** (태그 데이터)
  - `id` (Int, PK, auto increment)
  - `name` (String, 최대 길이 10자)
- **Images** (이미지 데이터)
  - `id` (Int, PK, auto increment)
  - `todoId` (Int, FK)
  - `url` (String)
- **TodosAndTags** (할 일-태그 조인 테이블)
  - `todoId` (Int, FK)
  - `tagId` (Int, FK)
- **TempTodos** (임시저장된 Todo)
  - `id` (Int, PK, auto increment)
  - `todoId` (Int, FK)

## 사용 기술
- Flutter 3.29.x
- Riverpod, hooks_riverpod (상태관리)
- Drift (로컬 DB)
- GoRouter (페이지 네비게이션)
- image_picker (이미지 첨부)
- Freezed (모델 관리)
- GetIt (의존성 관리)

## 실행 방법
### 프로젝트 초기화
```bash
flutter pub get
flutter pub run build_runner build
```

### 프로젝트 실행
```bash
flutter run
```

### 프로젝트 설치 (릴리즈 빌드)
```bash
flutter build apk --release && flutter install
```

## 프로젝트 설명
1. LocalDatabase CRUD를 하나의 기능으로 판단하여 여러 Feature Layer를 사용하는 게 아닌 단일 Feature로 개발하였습니다.
2. Todo 테이블에 임시저장 플래그를 추가하는 대신 TempTodo라는 임시저장 Todo 목록을 관리하는 테이블을 별도로 두어, 임시저장한 Todo를 저장 시 TempTodo만 제거하면 되는 구조로 설계했습니다.
3. BottomSheet나 Dialog 등 작은 UI 패널에서는 특정 목록이 필요한 경우 Notifier를 새로 만들기보다 LocalDatabaseRepository와 직접 소통하는 Provider를 명생성해 사용했습니다.
