local opt = vim.opt

-- tab/indent
opt.tabstop = 2 -- 탭 하나의 너비
opt.shiftwidth = 2 -- 들여쓰기의 너비
opt.softtabstop = 2 -- 에디팅 중 탭을 누르면 추가되는 공간의 개수
opt.expandtab = true -- 탭을 공백으로 치환함
opt.smartindent = true -- 파일에 따른 자동 들여쓰기 설정
opt.wrap = false -- 긴 글이 화면 밖을 넘어가도 자동 줄바꿈되지 않도록 설정

-- search
opt.incsearch = true -- 검색어 입력 즉시 하이라이트
opt.ignorecase = true -- 대소문자를 구분하지 않음
opt.smartcase = true -- 검색어에 대문자 포함시 대소문자를 구분함

-- visual
opt.number = true -- 라인 넘버 표시
opt.relativenumber = true -- 상대적 라인 넘버 표시
opt.termguicolors = true -- 터미널의 색 스킴 지원
opt.signcolumn = "yes" -- 라인넘버 옆 공간 활성화(디버깅, 버전관리 아이콘 등)

-- etc
opt.encoding = "UTF-8" -- 기본 문자 인코딩
opt.cmdheight = 1 -- 커맨드창 높이
opt.scrolloff = 10 -- 스크롤이 시작되는 높이 설정

-- clipboard
opt.clipboard = "unnamedplus"

-- diagnostics popoup time
opt.updatetime = 1500
