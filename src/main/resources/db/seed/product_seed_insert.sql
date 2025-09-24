-- Category Inserts
-- 부모 카테고리 (1~3)
INSERT INTO category (category_id, category_name, category_code, parent_category_id, level, display_order) VALUES
                                                                                                               (1, '음료', 'BEVERAGE', NULL, 1, 1),
                                                                                                               (2, '푸드', 'FOOD', NULL, 1, 2),
                                                                                                               (3, '세트상품', 'SET', NULL, 3, 3),
                                                                                                               (4, 'MD상품', 'MD_GOODS', NULL, 1, 4);

-- 음료 하위 (4~9)
INSERT INTO category (category_id, category_name, category_code, parent_category_id, level, display_order) VALUES
                                                                                                               (5, '커피', 'COFFEE', 1, 2, 1),
                                                                                                               (6, '라떼', 'LATTE', 1, 2, 2),
                                                                                                               (7, '주스 & 드링크', 'JUICE', 1, 2, 3),
                                                                                                               (8, '바나치노 & 스무디', 'SMOOTHIE', 1, 2, 4),
                                                                                                               (9, '티 & 에이드', 'TEA', 1, 2, 5);

select * from category;

-- Product Inserts
-- 커피 카테고리 (category_id = 4)
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (1, '아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483393071.jpg', 2500, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (2, '시그니처아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483411048.jpg', 2900, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (3, '디카페인 아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483431964.jpg', 3000, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (4, '바나리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483455094.jpg', 4000, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (5, '디카페인 바나리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483473824.jpg', 5000, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (6, '핑크아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250826_1756174300499.jpg', 3000, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (7, '디카페인 핑크아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250826_1756174339522.jpg', 3500, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (8, '핑크카페라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250826_1756174320574.jpg', 3500, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (9, '디카페인 핑크카페라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250826_1756174355269.jpg', 4000, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (10, '허니아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483508394.jpg', 3100, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (11, '디카페인 허니아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483528314.jpg', 3600, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (12, '유자셔벗아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483714564.jpg', 4400, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (13, '디카페인 유자셔벗아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483734534.jpg', 4900, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (14, '제로슈가 스위트아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483760950.jpg', 3100, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (15, '디카페인 제로슈가 스위트아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483783039.jpg', 3600, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (16, '헛개리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483808226.jpg', 3100, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (17, '디카페인 헛개리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483830035.jpg', 3600, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (18, '빅바나 헛개리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483860951.jpg', 4700, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (19, '빅바나 디카페인 헛개리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483880438.jpg', 5700, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (20, '화이트아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483899798.jpg', 3100, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (21, '디카페인 화이트아메리카노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483916353.jpg', 3600, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (22, '클래식밀크커피', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483937670.jpg', 2700, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (23, '빅바나 클래식밀크커피', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755483986870.jpg', 3700, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (79, '토피넛라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755486147609.jpg', 3800, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (80, '피스타치오라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487009113.jpg', 3800, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (81, '딸기라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487023915.jpg', 4000, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (82, '홍시라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487037585.jpg', 4000, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (83, '토마토생과일쥬스', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487095689.jpg', 4500, 7);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (84, '딸기쥬스', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487107965.jpg', 4000, 7);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (85, '망고쥬스', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487121681.jpg', 4000, 7);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (86, '홍시쥬스', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487132659.jpg', 4000, 7);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (87, '복숭아요거트드링크', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487145785.jpg', 4300, 7);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (88, '딸기요거트드링크', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487156721.jpg', 4000, 7);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (89, '플레인요거트드링크', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487167541.jpg', 3800, 7);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (90, '딸기요거트스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487205487.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (91, '플레인요거트스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487532365.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (92, '레몬요거트스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487551391.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (93, '망고요거트스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487626137.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (94, '탐라는감귤스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487184055.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (95, '제주말차바나치노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487216335.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (96, '꿀배스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487226679.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (97, '꿀자몽스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487242645.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (98, '토마토요구르트스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487565763.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (99, '밀크소다바나치노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487256387.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (100, '콜드브루바나치노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487272121.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (101, '초콜릿칩쉐이크', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487284201.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (102, '커피칩쉐이크', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487298747.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (103, '망고치즈바나치노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487485377.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (104, '초코쉐이크', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487500521.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (105, '바닐라쉐이크', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487519561.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (106, '제주청귤레몬스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487640131.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (107, '딸기복숭아스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487655325.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (108, '딸기스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487671567.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (109, '망고스무디', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487684077.jpg', 4000, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (110, '쿠앤크바나치노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487696475.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (111, '자바칩바나치노', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487711345.jpg', 4500, 8);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (112, '머스캣블랙티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755487803751.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (113, '요구르트레몬에이드', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492753038.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (114, '라임민트스파클러', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492764676.jpg', 3500, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (115, '체리콕', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492779364.jpg', 3500, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (116, '유자민트티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492795760.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (117, '애플캐모마일스위티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492809866.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (118, '딸기코코레모네이드', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492823942.jpg', 4000, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (119, '헛개차', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492836969.jpg', 2500, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (120, '빅바나 헛개차', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492862766.jpg', 3500, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (121, '탐라는감귤티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492888624.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (122, '허니유자티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492921484.jpg', 3500, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (123, '제로슈가 레몬아이스티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492944884.jpg', 3000, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (124, '빅바나 제로슈가 레몬아이스티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492960412.jpg', 4000, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (125, '제로슈가 복숭아아이스티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492975682.jpg', 3000, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (126, '빅바나 제로슈가 복숭아아이스티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755492993602.jpg', 4000, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (127, '망고홍차아이스티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493016042.jpg', 2800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (128, '플러스 망고홍차아이스티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493035420.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (129, 'NEW복숭아아이스티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493065288.jpg', 3500, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (130, '얼음동동식혜', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493104874.jpg', 3000, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (131, '빅바나 얼음동동식혜', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493262582.jpg', 4000, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (132, '자몽허니블랙티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250904_1756943064775.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (133, '문경오미자티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493446776.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (134, '제주청귤티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493463934.jpg', 3500, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (135, '제주청귤에이드', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493483313.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (136, '복숭아에이드', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493502224.jpg', 4300, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (137, '레몬에이드', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493523080.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (138, '자몽에이드', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493544782.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (139, '청포도에이드', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493560565.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (140, '레몬티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493578583.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (141, '자몽티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493593559.jpg', 3800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (142, '캐모마일', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250904_1756943033064.jpg', 2800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (143, '히비스커스', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250904_1756943078939.jpg', 2800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (144, '얼그레이', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250904_1756943093947.jpg', 2800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (145, '페퍼민트', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250904_1756943113309.jpg', 2800, 9);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (146, '허니브레드', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493881751.jpg', 4700, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (147, '더블크로플', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493898083.jpg', 4200, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (148, '아침란', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493943844.jpg', 2000, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (149, '멜론크림빵', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493954943.jpg', 3500, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (150, '떠먹는 요거트딸기케이크', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493974642.jpg', 3900, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (151, '크레이프 롤케이크', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755493989109.jpg', 4500, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (152, '소불고기치즈파니니', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494003108.jpg', 4900, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (153, '매콤닭가슴살파니니', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494017551.jpg', 4900, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (154, '크로크무슈', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494164463.jpg', 3500, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (155, '에그듬뿍모닝샌드위치', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250820_1755668577637.jpg', 2300, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (156, '게살듬뿍모닝샌드위치', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250820_1755668555573.jpg', 2300, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (157, '클래식카스테라', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494083173.jpg', 2000, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (158, '핫치킨부리또', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494095524.jpg', 4900, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (159, '버터리소금빵', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494112083.jpg', 2800, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (160, '햄치즈잉글리시머핀', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494123621.jpg', 3200, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (161, '플레인베이글', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494136556.jpg', 1900, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (162, '어니언베이글', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494151427.jpg', 1900, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (163, '폴리크림치즈', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494189190.jpg', 900, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (164, '유자마카롱', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494203093.jpg', 2100, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (165, '말차초코마카롱', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494218926.jpg', 2100, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (166, '순우유마카롱', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494233016.jpg', 2100, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (167, '블루베리요거트마카롱', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494248951.jpg', 2100, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (168, '초코가나슈마카롱', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494265137.jpg', 2100, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (169, '아메리칸쿠키', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494282086.jpg', 2300, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (170, '더블초코칩쿠키', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494297389.jpg', 2300, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (171, '오트밀크랜베리쿠키', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494310795.jpg', 2300, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (172, '말렌카케이크호두', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494336507.jpg', 5500, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (173, '말렌카케이크코코아', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494351020.jpg', 5500, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (174, '베이커리 박스', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494368679.jpg', 500, 2);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (175, '아침란 세트', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494555793.jpg', 4000, 3);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (176, '소불고기치즈파니니 세트', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494571177.jpg', 6900, 3);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (177, '매콤 닭가슴살파니니 세트', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494586371.jpg', 6900, 3);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (178, '크로크무슈 세트', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494601280.jpg', 5500, 3);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (179, '핫치킨부리또 세트', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494626092.jpg', 6900, 3);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (180, '플레인베이글 세트', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494643489.jpg', 3900, 3);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (181, '어니언베이글 세트', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494661589.jpg', 3900, 3);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (182, '햄치즈머핀 세트', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755494681923.jpg', 5200, 3);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (183, '바나프레소 화이트 텀블러 900ml', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250820_1755667974330.jpg', 14800, 4);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (184, '바나프레소 빅머그', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755496073605.jpg', 9000, 4);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (185, '머그컵_화이트', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/img_6d42f28c45f5.png', 9000, 4);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (186, '머그컵_핑크', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/img_4cbc5ca0f458.png', 9000, 4);-- 커피 카테고리 상품들 (category_id = 5)


-- 라떼 카테고리 상품들 (category_id = 6)
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (24, '카페라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484014464.jpg', 3300, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (25, '디카페인 카페라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484041833.jpg', 3800, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (26, '빅바나 카페라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484060564.jpg', 4500, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (27, '빅바나 디카페인 카페라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484080279.jpg', 5500, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (28, '크리미라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484120648.jpg', 3900, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (29, '디카페인 크리미라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484140952.jpg', 4400, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (30, '빅바나 크리미라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484176528.jpg', 5200, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (31, '빅바나 디카페인 크리미라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484198192.jpg', 6200, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (32, '헛개크리미라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484237302.jpg', 4100, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (33, '디카페인 헛개크리미라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484256022.jpg', 4600, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (34, '바닐라라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484278361.jpg', 3900, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (35, '저당 바닐라라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250908_1757288122899.jpg', 4400, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (36, '디카페인 바닐라라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484324812.jpg', 4400, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (37, '저당 디카페인 바닐라라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250908_1757288142983.jpg', 4900, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (38, '빅바나 바닐라라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484420060.jpg', 5200, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (39, '저당 빅바나 바닐라라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250908_1757288188841.jpg', 5700, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (40, '빅바나 디카페인 바닐라라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484464250.jpg', 6200, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (41, '저당 빅바나 디카페인 바닐라라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250908_1757288213943.jpg', 6700, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (42, '스위티소금라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484528428.jpg', 4400, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (43, '디카페인 스위티소금라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484554204.jpg', 4900, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (44, '연유라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250901_1756686124919.jpg', 4400, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (45, '디카페인 연유라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484635474.jpg', 4900, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (46, '카페모카', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484658760.jpg', 4400, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (47, '디카페인 카페모카', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484677090.jpg', 4900, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (48, '밀크카라멜마키아또', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484707505.jpg', 4400, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (49, '디카페인 밀크카라멜마키아또', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484725146.jpg', 4900, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (50, '시나몬라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484744925.jpg', 4400, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (51, '디카페인 시나몬라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484762886.jpg', 4900, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (52, '피스타치오카페라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484784448.jpg', 4400, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (53, '디카페인 피스타치오카페라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755484810850.jpg', 4900, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (54, '에스프레소', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485097146.jpg', 2500, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (55, '디카페인 에스프레소', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485115828.jpg', 3000, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (56, '콜드브루', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485167080.jpg', 3300, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (57, '빅바나 콜드브루', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485186422.jpg', 4300, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (58, '콜드브루 라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485212713.jpg', 3800, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (59, '바닐라 콜드브루', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485243760.jpg', 4000, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (60, '저당 바닐라 콜드브루', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250908_1757288231573.jpg', 4500, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (61, '돌체 콜드브루', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485302744.jpg', 4500, 5);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (62, '제주말차라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485337990.jpg', 3800, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (63, '멜론라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485351024.jpg', 4500, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (64, '딸기크리미라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485364767.jpg', 4500, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (65, '제주말차크리미라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485379701.jpg', 4300, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (66, '단짠치즈티라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485686458.jpg', 4000, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (67, '헛개버블티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485703344.jpg', 4500, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (68, '영암고구마라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485733761.jpg', 3800, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (69, '미숫가루라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485749536.jpg', 3800, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (70, '얼그레이밀크티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485808969.jpg', 3800, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (71, '빅바나 미숫가루라떼', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485765501.jpg', 5000, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (72, '저당 얼그레이밀크티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250908_1757288267679.jpg', 4300, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (73, '얼그레이버블티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755485972137.jpg', 4300, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (74, '저당 얼그레이버블티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250908_1757288287245.jpg', 4800, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (75, '흑당밀크티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755486002487.jpg', 3800, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (76, '흑당버블티', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755486018415.jpg', 4300, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (77, '리얼초코', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755486037347.jpg', 3800, 6);
INSERT INTO product (product_id, product_name, product_content, product_photo, price, category_id) VALUES (78, '빅바나 리얼초코', NULL, 'https://www.banapresso.com/from_open_storage?ws=fprocess&file=banapresso/menu/new_img_ice_20250818_1755486054113.jpg', 5000, 6);

-- 2. product 테이블 메뉴 설명 업데이트
UPDATE product SET product_content = '진한 에스프레소의 깊은 맛과 향을 물로 희석한 클래식 커피' WHERE product_id = 1;
UPDATE product SET product_content = '바나프레소만의 시그니처 블렌딩으로 더욱 풍부한 맛의 아메리카노' WHERE product_id = 2;
UPDATE product SET product_content = '카페인을 제거한 원두로 만든 부담 없는 아메리카노' WHERE product_id = 3;
UPDATE product SET product_content = '바나나의 달콤함이 더해진 바나프레소 시그니처 아메리카노' WHERE product_id = 4;
UPDATE product SET product_content = '카페인 없는 바나나 풍미의 특별한 아메리카노' WHERE product_id = 5;
UPDATE product SET product_content = '핑크빛깔의 상큼하고 달콤한 프리미엄 아메리카노' WHERE product_id = 6;
UPDATE product SET product_content = '카페인 제거한 핑크 아메리카노로 부담없이 즐기는 달콤함' WHERE product_id = 7;
UPDATE product SET product_content = '핑크빛 우유가 어우러진 부드럽고 달콤한 카페라떼' WHERE product_id = 8;
UPDATE product SET product_content = '카페인 없는 핑크 카페라떼로 언제나 부담없이' WHERE product_id = 9;
UPDATE product SET product_content = '천연 꿀의 달콤함이 가미된 부드러운 아메리카노' WHERE product_id = 10;
UPDATE product SET product_content = '카페인 제거한 허니 아메리카노로 달콤함을 부담없이' WHERE product_id = 11;
UPDATE product SET product_content = '상큼한 유자셔벗의 시원함과 커피의 조화' WHERE product_id = 12;
UPDATE product SET product_content = '카페인 없는 유자셔벗 아메리카노로 상큼함을 부담없이' WHERE product_id = 13;
UPDATE product SET product_content = '설탕 대신 천연 감미료로 달콤함을 더한 건강한 아메리카노' WHERE product_id = 14;
UPDATE product SET product_content = '카페인과 설탕 모두 제거한 건강한 스위트 아메리카노' WHERE product_id = 15;
UPDATE product SET product_content = '숙취해소에 좋은 헛개나무 추출물이 들어간 특별한 아메리카노' WHERE product_id = 16;
UPDATE product SET product_content = '카페인 없는 헛개리카노로 숙취해소 효과는 그대로' WHERE product_id = 17;
UPDATE product SET product_content = '대용량 사이즈의 헛개리카노로 더 오래 즐기는 숙취해소' WHERE product_id = 18;
UPDATE product SET product_content = '대용량 디카페인 헛개리카노로 부담없이 오래 즐기기' WHERE product_id = 19;
UPDATE product SET product_content = '우유거품이 올라간 부드럽고 고소한 화이트 아메리카노' WHERE product_id = 20;
UPDATE product SET product_content = '카페인 제거한 화이트 아메리카노로 부드러움을 부담없이' WHERE product_id = 21;
UPDATE product SET product_content = '진한 커피와 부드러운 우유의 클래식한 조화' WHERE product_id = 22;
UPDATE product SET product_content = '대용량 사이즈의 클래식 밀크커피로 더 오래 즐기기' WHERE product_id = 23;
UPDATE product SET product_content = '에스프레소와 스팀밀크의 완벽한 조화, 클래식 카페라떼' WHERE product_id = 24;
UPDATE product SET product_content = '카페인 제거한 카페라떼로 부담없이 즐기는 부드러움' WHERE product_id = 25;
UPDATE product SET product_content = '대용량 사이즈의 카페라떼로 더 오래 즐기는 부드러움' WHERE product_id = 26;
UPDATE product SET product_content = '대용량 디카페인 카페라떼로 부담없이 오래 즐기기' WHERE product_id = 27;
UPDATE product SET product_content = '크림의 부드러움이 더해진 진한 맛의 프리미엄 라떼' WHERE product_id = 28;
UPDATE product SET product_content = '카페인 없는 크리미라떼로 부드러운 크림맛을 부담없이' WHERE product_id = 29;
UPDATE product SET product_content = '대용량 크리미라떼로 더 오래 즐기는 부드러운 크림맛' WHERE product_id = 30;
UPDATE product SET product_content = '대용량 디카페인 크리미라떼로 부담없이 오래 즐기기' WHERE product_id = 31;
UPDATE product SET product_content = '헛개나무 추출물과 크림이 만난 특별한 라떼' WHERE product_id = 32;
UPDATE product SET product_content = '카페인 없는 헛개크리미라떼로 숙취해소와 부드러움을 동시에' WHERE product_id = 33;
UPDATE product SET product_content = '달콤한 바닐라 시럽이 들어간 향긋한 라떼' WHERE product_id = 34;
UPDATE product SET product_content = '설탕 대신 천연 감미료를 사용한 건강한 바닐라라떼' WHERE product_id = 35;
UPDATE product SET product_content = '카페인 제거한 바닐라라떼로 향긋함을 부담없이' WHERE product_id = 36;
UPDATE product SET product_content = '카페인과 설탕 모두 줄인 건강한 디카페인 바닐라라떼' WHERE product_id = 37;
UPDATE product SET product_content = '대용량 바닐라라떼로 더 오래 즐기는 달콤한 바닐라향' WHERE product_id = 38;
UPDATE product SET product_content = '대용량 저당 바닐라라떼로 건강하게 오래 즐기기' WHERE product_id = 39;
UPDATE product SET product_content = '대용량 디카페인 바닐라라떼로 부담없이 오래 즐기기' WHERE product_id = 40;
UPDATE product SET product_content = '대용량 저당 디카페인 바닐라라떼로 가장 건강하게' WHERE product_id = 41;
UPDATE product SET product_content = '달콤함과 짠맛의 절묘한 조화를 이룬 특별한 라떼' WHERE product_id = 42;
UPDATE product SET product_content = '카페인 없는 스위티소금라떼로 단짠맛을 부담없이' WHERE product_id = 43;
UPDATE product SET product_content = '진한 연유의 달콤함이 가득한 베트남 스타일 라떼' WHERE product_id = 44;
UPDATE product SET product_content = '카페인 제거한 연유라떼로 달콤함을 부담없이' WHERE product_id = 45;
UPDATE product SET product_content = '진한 초콜릿과 에스프레소의 달콤쌉싸름한 조화' WHERE product_id = 46;
UPDATE product SET product_content = '카페인 없는 카페모카로 초콜릿맛을 부담없이' WHERE product_id = 47;
UPDATE product SET product_content = '카라멜 시럽과 우유거품이 어우러진 달콤한 마키아또' WHERE product_id = 48;
UPDATE product SET product_content = '카페인 제거한 마키아또로 달콤함을 부담없이' WHERE product_id = 49;
UPDATE product SET product_content = '따뜻한 시나몬 향이 가득한 향긋한 라떼' WHERE product_id = 50;
UPDATE product SET product_content = '카페인 없는 시나몬라떼로 향긋함을 부담없이' WHERE product_id = 51;
UPDATE product SET product_content = '고소한 피스타치오 풍미가 가득한 프리미엄 라떼' WHERE product_id = 52;
UPDATE product SET product_content = '카페인 제거한 피스타치오 라떼로 고소함을 부담없이' WHERE product_id = 53;
UPDATE product SET product_content = '진한 에스프레소 원액 그대로의 강렬한 커피' WHERE product_id = 54;
UPDATE product SET product_content = '카페인 제거한 에스프레소로 진한 맛은 그대로' WHERE product_id = 55;
UPDATE product SET product_content = '차갑게 우려낸 부드럽고 깔끔한 콜드브루 커피' WHERE product_id = 56;
UPDATE product SET product_content = '대용량 콜드브루로 더 오래 즐기는 깔끔한 맛' WHERE product_id = 57;
UPDATE product SET product_content = '콜드브루와 우유의 부드러운 조화' WHERE product_id = 58;
UPDATE product SET product_content = '바닐라 시럽이 들어간 달콤한 콜드브루' WHERE product_id = 59;
UPDATE product SET product_content = '설탕 대신 천연 감미료를 사용한 건강한 바닐라 콜드브루' WHERE product_id = 60;
UPDATE product SET product_content = '달콤한 돌체 시럽이 들어간 프리미엄 콜드브루' WHERE product_id = 61;
UPDATE product SET product_content = '제주산 말차 파우더로 만든 진한 녹차 라떼' WHERE product_id = 62;
UPDATE product SET product_content = '달콤한 멜론 풍미가 가득한 상큼한 라떼' WHERE product_id = 63;
UPDATE product SET product_content = '상큼달콤한 딸기와 부드러운 크림의 조화' WHERE product_id = 64;
UPDATE product SET product_content = '제주 말차와 크림이 만난 고급스러운 라떼' WHERE product_id = 65;
UPDATE product SET product_content = '달콤함과 짠맛이 어우러진 특별한 치즈 라떼' WHERE product_id = 66;
UPDATE product SET product_content = '쫄깃한 타피오카펄과 헛개차의 건강한 조화' WHERE product_id = 67;
UPDATE product SET product_content = '영암산 고구마의 달콤함이 가득한 라떼' WHERE product_id = 68;
UPDATE product SET product_content = '고소한 미숫가루의 전통적인 맛이 살아있는 라떼' WHERE product_id = 69;
UPDATE product SET product_content = '향긋한 얼그레이 티와 부드러운 우유의 조화' WHERE product_id = 70;
UPDATE product SET product_content = '대용량 미숫가루라떼로 더 오래 즐기는 고소함' WHERE product_id = 71;
UPDATE product SET product_content = '설탕 대신 천연 감미료를 사용한 건강한 얼그레이 밀크티' WHERE product_id = 72;
UPDATE product SET product_content = '쫄깃한 타피오카펄과 얼그레이의 향긋한 조화' WHERE product_id = 73;
UPDATE product SET product_content = '저당 타피오카펄과 얼그레이로 건강하게 즐기는 버블티' WHERE product_id = 74;
UPDATE product SET product_content = '진한 흑설탕과 부드러운 우유의 달콤한 조화' WHERE product_id = 75;
UPDATE product SET product_content = '쫄깃한 타피오카펄과 흑당의 달콤한 버블티' WHERE product_id = 76;
UPDATE product SET product_content = '진짜 초콜릿을 사용한 진하고 달콤한 초콜릿 음료' WHERE product_id = 77;
UPDATE product SET product_content = '대용량 리얼초코로 더 오래 즐기는 진한 초콜릿맛' WHERE product_id = 78;
UPDATE product SET product_content = '고소한 토피넛 풍미가 가득한 프리미엄 라떼' WHERE product_id = 79;
UPDATE product SET product_content = '고급 피스타치오의 고소하고 부드러운 라떼' WHERE product_id = 80;
UPDATE product SET product_content = '상큼달콤한 딸기가 가득한 과일 라떼' WHERE product_id = 81;
UPDATE product SET product_content = '달콤한 홍시의 가을 정취를 담은 계절 라떼' WHERE product_id = 82;
UPDATE product SET product_content = '신선한 토마토로 만든 건강한 생과일 주스' WHERE product_id = 83;
UPDATE product SET product_content = '상큼달콤한 딸기 100% 생과일 주스' WHERE product_id = 84;
UPDATE product SET product_content = '열대과일 망고의 달콤함이 가득한 주스' WHERE product_id = 85;
UPDATE product SET product_content = '달콤한 홍시로 만든 가을 한정 과일 주스' WHERE product_id = 86;
UPDATE product SET product_content = '상큼한 복숭아와 요거트의 상큼한 조화' WHERE product_id = 87;
UPDATE product SET product_content = '딸기와 요거트의 상큼달콤한 드링크' WHERE product_id = 88;
UPDATE product SET product_content = '깔끔하고 담백한 플레인 요거트 드링크' WHERE product_id = 89;
UPDATE product SET product_content = '상큼한 딸기와 요거트의 시원한 스무디' WHERE product_id = 90;
UPDATE product SET product_content = '부드럽고 깔끔한 플레인 요거트 스무디' WHERE product_id = 91;
UPDATE product SET product_content = '상큼한 레몬과 요거트의 새콤달콤한 스무디' WHERE product_id = 92;
UPDATE product SET product_content = '열대과일 망고와 요거트의 달콤한 스무디' WHERE product_id = 93;
UPDATE product SET product_content = '제주 감귤의 상큼함이 가득한 특별한 스무디' WHERE product_id = 94;
UPDATE product SET product_content = '제주산 말차로 만든 진한 녹차 바나치노' WHERE product_id = 95;
UPDATE product SET product_content = '달콤한 꿀배의 시원함이 가득한 스무디' WHERE product_id = 96;
UPDATE product SET product_content = '상큼한 자몽과 달콤한 꿀의 조화로운 스무디' WHERE product_id = 97;
UPDATE product SET product_content = '토마토와 요구르트의 건강한 조화 스무디' WHERE product_id = 98;
UPDATE product SET product_content = '탄산과 우유의 특별한 조화 바나치노' WHERE product_id = 99;
UPDATE product SET product_content = '콜드브루와 얼음의 시원한 바나치노' WHERE product_id = 100;
UPDATE product SET product_content = '초콜릿칩이 들어간 달콤한 아이스크림 쉐이크' WHERE product_id = 101;
UPDATE product SET product_content = '커피와 초콜릿칩의 씹는 재미가 있는 쉐이크' WHERE product_id = 102;
UPDATE product SET product_content = '망고와 치즈크림의 특별한 조화 바나치노' WHERE product_id = 103;
UPDATE product SET product_content = '진한 초콜릿 아이스크림으로 만든 달콤한 쉐이크' WHERE product_id = 104;
UPDATE product SET product_content = '부드러운 바닐라 아이스크림의 클래식 쉐이크' WHERE product_id = 105;
UPDATE product SET product_content = '제주 청귤과 레몬의 상큼한 만남 스무디' WHERE product_id = 106;
UPDATE product SET product_content = '딸기와 복숭아 두 과일의 달콤한 조화 스무디' WHERE product_id = 107;
UPDATE product SET product_content = '상큼달콤한 딸기 100% 과일 스무디' WHERE product_id = 108;
UPDATE product SET product_content = '열대과일 망고의 진한 달콤함 스무디' WHERE product_id = 109;
UPDATE product SET product_content = '쿠키앤크림의 달콤한 맛이 가득한 바나치노' WHERE product_id = 110;
UPDATE product SET product_content = '자바칩과 커피의 씹는 재미가 있는 바나치노' WHERE product_id = 111;
UPDATE product SET product_content = '상큼한 머스캣과 블랙티의 고급스러운 조화' WHERE product_id = 112;
UPDATE product SET product_content = '요구르트와 레몬의 상큼한 에이드' WHERE product_id = 113;
UPDATE product SET product_content = '라임과 민트의 상쾌한 탄산 음료' WHERE product_id = 114;
UPDATE product SET product_content = '체리와 콜라의 달콤한 탄산 음료' WHERE product_id = 115;
UPDATE product SET product_content = '유자와 민트의 상큼한 티 음료' WHERE product_id = 116;
UPDATE product SET product_content = '사과와 캐모마일의 편안한 허브티' WHERE product_id = 117;
UPDATE product SET product_content = '딸기와 코코넛의 트로피컬 레모네이드' WHERE product_id = 118;
UPDATE product SET product_content = '숙취해소에 좋은 전통 헛개차' WHERE product_id = 119;
UPDATE product SET product_content = '대용량 헛개차로 더 오래 즐기는 숙취해소' WHERE product_id = 120;
UPDATE product SET product_content = '제주 감귤의 상큼함이 담긴 특별한 티' WHERE product_id = 121;
UPDATE product SET product_content = '꿀과 유자의 달콤상큼한 전통차' WHERE product_id = 122;
UPDATE product SET product_content = '설탕 없이 즐기는 상큼한 레몬 아이스티' WHERE product_id = 123;
UPDATE product SET product_content = '대용량 제로슈가 레몬 아이스티로 더 건강하게' WHERE product_id = 124;
UPDATE product SET product_content = '설탕 없이 즐기는 달콤한 복숭아 아이스티' WHERE product_id = 125;
UPDATE product SET product_content = '대용량 제로슈가 복숭아 아이스티로 더 건강하게' WHERE product_id = 126;
UPDATE product SET product_content = '망고와 홍차의 달콤한 조화 아이스티' WHERE product_id = 127;
UPDATE product SET product_content = '망고 과육이 더 들어간 프리미엄 홍차 아이스티' WHERE product_id = 128;
UPDATE product SET product_content = '새로운 레시피로 더욱 달콤해진 복숭아 아이스티' WHERE product_id = 129;
UPDATE product SET product_content = '시원한 얼음이 동동 뜬 전통 식혜' WHERE product_id = 130;
UPDATE product SET product_content = '대용량 얼음동동 식혜로 더 오래 즐기는 전통음료' WHERE product_id = 131;
UPDATE product SET product_content = '자몽과 꿀, 블랙티의 상큼달콤한 조화' WHERE product_id = 132;
UPDATE product SET product_content = '문경산 오미자의 새콤달콤한 전통차' WHERE product_id = 133;
UPDATE product SET product_content = '제주 청귤의 상큼함이 가득한 티' WHERE product_id = 134;
UPDATE product SET product_content = '제주 청귤의 상큼한 탄산 에이드' WHERE product_id = 135;
UPDATE product SET product_content = '달콤한 복숭아의 상큼한 탄산 에이드' WHERE product_id = 136;
UPDATE product SET product_content = '상큼한 레몬의 클래식 탄산 에이드' WHERE product_id = 137;
UPDATE product SET product_content = '씁쓸달콤한 자몽의 상큼한 탄산 에이드' WHERE product_id = 138;
UPDATE product SET product_content = '달콤한 청포도의 상큼한 탄산 에이드' WHERE product_id = 139;
UPDATE product SET product_content = '상큼한 레몬과 홍차의 깔끔한 조화' WHERE product_id = 140;
UPDATE product SET product_content = '씁쓸달콤한 자몽과 홍차의 상큼한 조화' WHERE product_id = 141;
UPDATE product SET product_content = '편안함을 주는 캐모마일 허브티' WHERE product_id = 142;
UPDATE product SET product_content = '새콤한 맛과 예쁜 색깔의 히비스커스 허브티' WHERE product_id = 143;
UPDATE product SET product_content = '베르가못 향이 은은한 클래식 얼그레이' WHERE product_id = 144;
UPDATE product SET product_content = '상쾌한 민트의 시원한 허브티' WHERE product_id = 145;
UPDATE product SET product_content = '달콤한 꿀이 듬뿍 들어간 따뜻한 허니브레드' WHERE product_id = 146;
UPDATE product SET product_content = '바삭한 크루아상과 와플의 만남 더블크로플' WHERE product_id = 147;
UPDATE product SET product_content = '간편하고 영양만점인 아침식사용 달걀요리' WHERE product_id = 148;
UPDATE product SET product_content = '달콤한 멜론크림이 가득한 부드러운 빵' WHERE product_id = 149;
UPDATE product SET product_content = '상큼한 딸기와 요거트가 층층이 쌓인 케이크' WHERE product_id = 150;
UPDATE product SET product_content = '부드러운 크레이프 시트로 감싼 크림 롤케이크' WHERE product_id = 151;
UPDATE product SET product_content = '소불고기와 치즈가 들어간 따뜻한 파니니' WHERE product_id = 152;
UPDATE product SET product_content = '매콤한 닭가슴살이 들어간 건강한 파니니' WHERE product_id = 153;
UPDATE product SET product_content = '햄과 치즈가 들어간 프랑스식 그릴 샌드위치' WHERE product_id = 154;
UPDATE product SET product_content = '달걀이 듬뿍 들어간 든든한 모닝 샌드위치' WHERE product_id = 155;
UPDATE product SET product_content = '게살이 듬뿍 들어간 고급 모닝 샌드위치' WHERE product_id = 156;
UPDATE product SET product_content = '부드럽고 달콤한 전통 클래식 카스테라' WHERE product_id = 157;
UPDATE product SET product_content = '매콤한 치킨이 들어간 든든한 부리또' WHERE product_id = 158;
UPDATE product SET product_content = '버터와 소금의 조화가 일품인 프리미엄 빵' WHERE product_id = 159;
UPDATE product SET product_content = '햄과 치즈가 들어간 따뜻한 잉글리시 머핀' WHERE product_id = 160;
UPDATE product SET product_content = '담백하고 쫄깃한 기본 플레인 베이글' WHERE product_id = 161;
UPDATE product SET product_content = '고소한 양파가 들어간 풍미 가득한 베이글' WHERE product_id = 162;
UPDATE product SET product_content = '베이글과 함께 즐기는 부드러운 크림치즈' WHERE product_id = 163;
UPDATE product SET product_content = '상큼한 유자맛의 프랑스식 마카롱' WHERE product_id = 164;
UPDATE product SET product_content = '말차와 초콜릿의 조화로운 마카롱' WHERE product_id = 165;
UPDATE product SET product_content = '부드럽고 담백한 순우유 마카롱' WHERE product_id = 166;
UPDATE product SET product_content = '블루베리와 요거트의 상큼한 마카롱' WHERE product_id = 167;
UPDATE product SET product_content = '진한 초콜릿 가나슈가 들어간 마카롱' WHERE product_id = 168;
UPDATE product SET product_content = '미국식 바삭한 아메리칸 스타일 쿠키' WHERE product_id = 169;
UPDATE product SET product_content = '초콜릿칩이 듬뿍 들어간 진한 초콜릿 쿠키' WHERE product_id = 170;
UPDATE product SET product_content = '오트밀과 크랜베리의 건강한 조화 쿠키' WHERE product_id = 171;
UPDATE product SET product_content = '호두가 들어간 프리미엄 말렌카 케이크' WHERE product_id = 172;
UPDATE product SET product_content = '진한 코코아맛의 프리미엄 말렌카 케이크' WHERE product_id = 173;
UPDATE product SET product_content = '베이커리 포장용 전용 박스' WHERE product_id = 174;
UPDATE product SET product_content = '아침란과 음료가 포함된 든든한 세트메뉴' WHERE product_id = 175;
UPDATE product SET product_content = '소불고기 치즈파니니와 음료가 포함된 세트메뉴' WHERE product_id = 176;
UPDATE product SET product_content = '매콤 닭가슴살파니니와 음료가 포함된 세트메뉴' WHERE product_id = 177;
UPDATE product SET product_content = '크로크무슈와 음료가 포함된 세트메뉴' WHERE product_id = 178;
UPDATE product SET product_content = '핫치킨부리또와 음료가 포함된 세트메뉴' WHERE product_id = 179;
UPDATE product SET product_content = '플레인베이글과 음료가 포함된 세트메뉴' WHERE product_id = 180;
UPDATE product SET product_content = '어니언베이글과 음료가 포함된 세트메뉴' WHERE product_id = 181;
UPDATE product SET product_content = '햄치즈머핀과 음료가 포함된 세트메뉴' WHERE product_id = 182;
UPDATE product SET product_content = '바나프레소 로고가 새겨진 화이트 텀블러 900ml' WHERE product_id = 183;
UPDATE product SET product_content = '바나프레소 로고가 새겨진 대용량 빅머그컵' WHERE product_id = 184;
UPDATE product SET product_content = '바나프레소 로고가 새겨진 화이트 머그컵' WHERE product_id = 185;
UPDATE product SET product_content = '바나프레소 로고가 새겨진 핑크 머그컵' WHERE product_id = 186;

INSERT INTO allergen (allergen_id, allergen_code, allergen_name, product_id) VALUES
-- 바나리카노 (바나나 시럽 - 대두)
(1, 'SOY', '대두', 4),
(2, 'SOY', '대두', 5), -- 디카페인 바나리카노

-- 핑크카페라떼 (우유)
(3, 'MILK', '우유', 8),
(4, 'MILK', '우유', 9), -- 디카페인 핑크카페라떼

-- 화이트아메리카노 (우유)
(5, 'MILK', '우유', 20),
(6, 'MILK', '우유', 21), -- 디카페인 화이트아메리카노

-- 클래식밀크커피 (우유)
(7, 'MILK', '우유', 22),
(8, 'MILK', '우유', 23), -- 빅바나 클래식밀크커피

-- 라떼류 (모두 우유 포함)
(9, 'MILK', '우유', 24), -- 카페라떼
(10, 'MILK', '우유', 25), -- 디카페인 카페라떼
(11, 'MILK', '우유', 26), -- 빅바나 카페라떼
(12, 'MILK', '우유', 27), -- 빅바나 디카페인 카페라떼
(13, 'MILK', '우유', 28), -- 바닐라라떼
(14, 'MILK', '우유', 29), -- 디카페인 바닐라라떼
(15, 'MILK', '우유', 30), -- 빅바나 바닐라라떼
(16, 'MILK', '우유', 31), -- 빅바나 디카페인 바닐라라떼
(17, 'MILK', '우유', 32), -- 헤이즐넛라떼
(18, 'MILK', '우유', 33), -- 디카페인 헤이즐넛라떼
(19, 'MILK', '우유', 34), -- 빅바나 헤이즐넛라떼
(20, 'MILK', '우유', 35), -- 빅바나 디카페인 헤이즐넛라떼
(21, 'MILK', '우유', 36), -- 카라멜마끼아또
(22, 'MILK', '우유', 37), -- 디카페인 카라멜마끼아또
(23, 'MILK', '우유', 38), -- 빅바나 카라멜마끼아또
(24, 'MILK', '우유', 39), -- 빅바나 디카페인 카라멜마끼아또
(25, 'MILK', '우유', 40), -- 화이트초콜릿모카
(26, 'MILK', '우유', 41), -- 디카페인 화이트초콜릿모카
(27, 'MILK', '우유', 42), -- 빅바나 화이트초콜릿모카
(28, 'MILK', '우유', 43), -- 빅바나 디카페인 화이트초콜릿모카

-- 헤이즐넛라떼 (견과류 추가)
(29, 'NUT', '견과류', 32), -- 헤이즐넛라떼
(30, 'NUT', '견과류', 33), -- 디카페인 헤이즐넛라떼
(31, 'NUT', '견과류', 34), -- 빅바나 헤이즐넛라떼
(32, 'NUT', '견과류', 35), -- 빅바나 디카페인 헤이즐넛라떼

-- 모카라떼 계열 (우유)
(33, 'MILK', '우유', 44), -- 카페모카
(34, 'MILK', '우유', 45), -- 디카페인 카페모카
(35, 'MILK', '우유', 46), -- 빅바나 카페모카
(36, 'MILK', '우유', 47), -- 빅바나 디카페인 카페모카
(37, 'MILK', '우유', 48), -- 초콜릿라떼
(38, 'MILK', '우유', 49), -- 디카페인 초콜릿라떼
(39, 'MILK', '우유', 50), -- 빅바나 초콜릿라떼
(40, 'MILK', '우유', 51), -- 빅바나 디카페인 초콜릿라떼

-- 피스타치오라떼 (우유 + 견과류)
(41, 'MILK', '우유', 52), -- 피스타치오라떼
(42, 'NUT', '견과류', 52), -- 피스타치오라떼
(43, 'MILK', '우유', 53), -- 디카페인 피스타치오라떼
(44, 'NUT', '견과류', 53), -- 디카페인 피스타치오라떼

-- 기타 라떼류 (우유)
(45, 'MILK', '우유', 62), -- 연유라떼
(46, 'MILK', '우유', 63), -- 디카페인 연유라떼
(47, 'MILK', '우유', 64), -- 빅바나 연유라떼
(48, 'MILK', '우유', 65), -- 빅바나 디카페인 연유라떼
(49, 'MILK', '우유', 66), -- 꿀라떼
(50, 'MILK', '우유', 67), -- 디카페인 꿀라떼
(51, 'MILK', '우유', 68), -- 빅바나 꿀라떼

-- 미숫가루라떼 (우유 + 대두 + 밀)
(52, 'MILK', '우유', 69), -- 미숫가루라떼
(53, 'SOY', '대두', 69), -- 미숫가루라떼
(54, 'WHEAT', '밀', 69), -- 미숫가루라떼
(55, 'MILK', '우유', 71), -- 빅바나 미숫가루라떼
(56, 'SOY', '대두', 71), -- 빅바나 미숫가루라떼
(57, 'WHEAT', '밀', 71), -- 빅바나 미숫가루라떼

-- 기타 라떼류
(58, 'MILK', '우유', 72), -- 그린티라떼
(59, 'MILK', '우유', 73), -- 디카페인 그린티라떼
(60, 'MILK', '우유', 74), -- 빅바나 그린티라떼
(61, 'MILK', '우유', 75), -- 빅바나 디카페인 그린티라떼
(62, 'MILK', '우유', 76), -- 얼그레이라떼
(63, 'MILK', '우유', 77), -- 디카페인 얼그레이라떼
(64, 'MILK', '우유', 78), -- 빅바나 얼그레이라떼

-- 토피넛라떼 (우유 + 견과류)
(65, 'MILK', '우유', 79), -- 토피넛라떼
(66, 'NUT', '견과류', 79), -- 토피넛라떼

-- 피스타치오라떼 (우유 + 견과류)
(67, 'MILK', '우유', 80), -- 피스타치오라떼
(68, 'NUT', '견과류', 80), -- 피스타치오라떼

-- 기타 라떼류
(69, 'MILK', '우유', 81), -- 자몽라떼
(70, 'MILK', '우유', 82), -- 레몬라떼

-- 요거트 드링크 (우유 + 유산균)
(71, 'MILK', '우유', 87), -- 플레인요거트
(72, 'MILK', '우유', 88), -- 딸기요거트
(73, 'MILK', '우유', 89), -- 블루베리요거트

-- 요거트 스무디 (우유 + 유산균)
(74, 'MILK', '우유', 90), -- 플레인요거트스무디
(75, 'MILK', '우유', 91), -- 딸기요거트스무디
(76, 'MILK', '우유', 92), -- 블루베리요거트스무디
(77, 'MILK', '우유', 93), -- 망고요거트스무디
(78, 'MILK', '우유', 98), -- 그린스무디

-- 바나치노/스무디 (우유 + 설탕/감미료)
(79, 'MILK', '우유', 95), -- 자바칩바나치노
(80, 'MILK', '우유', 99), -- 그린티바나치노
(81, 'MILK', '우유', 100), -- 초콜릿바나치노
(82, 'MILK', '우유', 101), -- 딸기바나치노
(83, 'MILK', '우유', 102), -- 바닐라바나치노
(84, 'MILK', '우유', 103), -- 카라멜바나치노
(85, 'MILK', '우유', 104), -- 오레오바나치노
(86, 'MILK', '우유', 105), -- 쿠키바나치노
(87, 'MILK', '우유', 110), -- 플레인스무디
(88, 'MILK', '우유', 111), -- 믹스베리스무디

-- 베이커리류 알레르기 정보

-- 브라우니 (밀 + 달걀 + 우유 + 견과류)
(89, 'WHEAT', '밀', 146), -- 브라우니
(90, 'EGG', '달걀', 146),
(91, 'MILK', '우유', 146),
(92, 'NUT', '견과류', 146),

-- 치즈케이크 (밀 + 달걀 + 우유)
(93, 'WHEAT', '밀', 147), -- 뉴욕치즈케이크
(94, 'EGG', '달걀', 147),
(95, 'MILK', '우유', 147),

-- 마카롱 (달걀 + 견과류)
(96, 'EGG', '달걀', 148), -- 마카롱
(97, 'NUT', '견과류', 148),

-- 쿠키류 (밀 + 달걀 + 우유 + 견과류)
(98, 'WHEAT', '밀', 149), -- 초콜릿칩쿠키
(99, 'EGG', '달걀', 149),
(100, 'MILK', '우유', 149),
(101, 'NUT', '견과류', 149),

(102, 'WHEAT', '밀', 150), -- 오트밀쿠키
(103, 'EGG', '달걀', 150),
(104, 'MILK', '우유', 150),

(105, 'WHEAT', '밀', 151), -- 버터쿠키
(106, 'EGG', '달걀', 151),
(107, 'MILK', '우유', 151),

-- 머핀류 (밀 + 달걀 + 우유)
(108, 'WHEAT', '밀', 152), -- 블루베리머핀
(109, 'EGG', '달걀', 152),
(110, 'MILK', '우유', 152),

(111, 'WHEAT', '밀', 153), -- 초콜릿머핀
(112, 'EGG', '달걀', 153),
(113, 'MILK', '우유', 153),

(114, 'WHEAT', '밀', 154), -- 바나나머핀
(115, 'EGG', '달걀', 154),
(116, 'MILK', '우유', 154),

-- 스콘류 (밀 + 달걀 + 우유)
(117, 'WHEAT', '밀', 155), -- 플레인스콘
(118, 'EGG', '달걀', 155),
(119, 'MILK', '우유', 155),

(120, 'WHEAT', '밀', 156), -- 크랜베리스콘
(121, 'EGG', '달걀', 156),
(122, 'MILK', '우유', 156),

(123, 'WHEAT', '밀', 157), -- 초콜릿스콘
(124, 'EGG', '달걀', 157),
(125, 'MILK', '우유', 157),

-- 도넛 (밀 + 달걀)
(126, 'WHEAT', '밀', 158), -- 글레이즈도넛
(127, 'EGG', '달걀', 158),

(128, 'WHEAT', '밀', 159), -- 초콜릿도넛
(129, 'MILK', '우유', 159),

(130, 'WHEAT', '밀', 160), -- 슈가도넛

-- 크루아상 (밀 + 달걀 + 우유)
(131, 'WHEAT', '밀', 161), -- 버터크루아상
(132, 'EGG', '달걀', 161),
(133, 'MILK', '우유', 161),

(134, 'WHEAT', '밀', 162), -- 초콜릿크루아상
(135, 'EGG', '달걀', 162),
(136, 'MILK', '우유', 162),

-- 와플 (밀 + 달걀 + 우유)
(137, 'WHEAT', '밀', 164), -- 벨기에와플
(138, 'EGG', '달걀', 164),
(139, 'MILK', '우유', 164),

(140, 'WHEAT', '밀', 165), -- 초콜릿와플
(141, 'EGG', '달걀', 165),
(142, 'MILK', '우유', 165),

-- 타르트류 (밀 + 달걀 + 우유)
(143, 'WHEAT', '밀', 166), -- 과일타르트
(144, 'EGG', '달걀', 166),
(145, 'MILK', '우유', 166),

(146, 'WHEAT', '밀', 167), -- 초콜릿타르트
(147, 'EGG', '달걀', 167),
(148, 'MILK', '우유', 167),

-- 파운드케이크류 (밀 + 달걀 + 우유)
(149, 'WHEAT', '밀', 168), -- 레몬파운드케이크
(150, 'EGG', '달걀', 168),
(151, 'MILK', '우유', 168),

(152, 'WHEAT', '밀', 169), -- 바닐라파운드케이크
(153, 'EGG', '달걀', 169),
(154, 'MILK', '우유', 169),

(155, 'WHEAT', '밀', 170), -- 초콜릿파운드케이크
(156, 'EGG', '달걀', 170),
(157, 'MILK', '우유', 170),

(158, 'WHEAT', '밀', 171), -- 녹차파운드케이크
(159, 'EGG', '달걀', 171),
(160, 'MILK', '우유', 171),

-- 말렌카케이크호두 (밀 + 달걀 + 우유 + 견과류)
(161, 'WHEAT', '밀', 172), -- 말렌카케이크호두
(162, 'EGG', '달걀', 172),
(163, 'MILK', '우유', 172),
(164, 'NUT', '견과류', 172),

-- 티라미수 (밀 + 달걀 + 우유)
(165, 'WHEAT', '밀', 173), -- 티라미수
(166, 'EGG', '달걀', 173),
(167, 'MILK', '우유', 173),

-- 추가 알레르기 정보 (시럽, 토핑 등)
-- 캐러멜 시럽 포함 제품 (아황산염 가능성)
(168, 'SULFITE', '아황산염', 36), -- 카라멜마끼아또
(169, 'SULFITE', '아황산염', 37), -- 디카페인 카라멜마끼아또
(170, 'SULFITE', '아황산염', 38), -- 빅바나 카라멜마끼아또
(171, 'SULFITE', '아황산염', 39), -- 빅바나 디카페인 카라멜마끼아또
(172, 'SULFITE', '아황산염', 103), -- 카라멜바나치노

-- 참깨 함유 제품 (베이커리에 참깨 토핑)
(173, 'SESAME', '참깨', 161), -- 버터크루아상 (참깨 토핑 버전)

-- 생선 젤라틴 함유 가능성 (젤리 토핑)
(174, 'FISH', '어류', 148), -- 마카롱 (젤라틴 사용 가능성)

-- 땅콩 함유 제품
(175, 'PEANUT', '땅콩', 149), -- 초콜릿칩쿠키 (땅콩 포함 버전)

-- 갑각류 (키토산 등 첨가물 가능성)
(176, 'SHELLFISH', '갑각류', 98), -- 그린스무디 (키토산 첨가 가능성)

-- 과일/채소 알레르기 정보 추가

-- 딸기 알레르기
(177, 'STRAWBERRY', '딸기', 88), -- 딸기요거트
(178, 'STRAWBERRY', '딸기', 91), -- 딸기요거트스무디
(179, 'STRAWBERRY', '딸기', 101), -- 딸기바나치노
(180, 'STRAWBERRY', '딸기', 111), -- 믹스베리스무디
(181, 'STRAWBERRY', '딸기', 166), -- 과일타르트 (딸기 토핑)

-- 블루베리 알레르기
(182, 'BLUEBERRY', '블루베리', 89), -- 블루베리요거트
(183, 'BLUEBERRY', '블루베리', 92), -- 블루베리요거트스무디
(184, 'BLUEBERRY', '블루베리', 111), -- 믹스베리스무디
(185, 'BLUEBERRY', '블루베리', 152), -- 블루베리머핀
(186, 'BLUEBERRY', '블루베리', 166), -- 과일타르트 (블루베리 토핑)

-- 망고 알레르기
(187, 'MANGO', '망고', 93), -- 망고요거트스무디
(188, 'MANGO', '망고', 166), -- 과일타르트 (망고 토핑)

-- 바나나 알레르기 (라텍스-과일 증후군)
(189, 'BANANA', '바나나', 4), -- 바나리카노
(190, 'BANANA', '바나나', 5), -- 디카페인 바나리카노
(191, 'BANANA', '바나나', 154), -- 바나나머핀
(192, 'BANANA', '바나나', 166), -- 과일타르트 (바나나 토핑)

-- 크랜베리 알레르기
(193, 'CRANBERRY', '크랜베리', 156), -- 크랜베리스콘
(194, 'CRANBERRY', '크랜베리', 111), -- 믹스베리스무디

-- 레몬 알레르기 (감귤류)
(195, 'CITRUS', '감귤류', 82), -- 레몬라떼
(196, 'CITRUS', '감귤류', 168), -- 레몬파운드케이크

-- 자몽 알레르기 (감귤류)
(197, 'CITRUS', '감귤류', 81), -- 자몽라떼

-- 유자 알레르기 (감귤류)
(198, 'CITRUS', '감귤류', 12), -- 유자셔벗아메리카노
(199, 'CITRUS', '감귤류', 13), -- 디카페인 유자셔벗아메리카노

-- 녹차 알레르기 (카페인 민감성 포함)
(200, 'GREENTEA', '녹차', 72), -- 그린티라떼
(201, 'GREENTEA', '녹차', 73), -- 디카페인 그린티라떼
(202, 'GREENTEA', '녹차', 74), -- 빅바나 그린티라떼
(203, 'GREENTEA', '녹차', 75), -- 빅바나 디카페인 그린티라떼
(204, 'GREENTEA', '녹차', 99), -- 그린티바나치노
(205, 'GREENTEA', '녹차', 98), -- 그린스무디
(206, 'GREENTEA', '녹차', 171), -- 녹차파운드케이크

-- 오렌지 알레르기 (감귤류)
(207, 'CITRUS', '감귤류', 166), -- 과일타르트 (오렌지 토핑)

-- 키위 알레르기 (라텍스-과일 증후군)
(208, 'KIWI', '키위', 98), -- 그린스무디
(209, 'KIWI', '키위', 166), -- 과일타르트 (키위 토핑)

-- 복숭아 알레르기 (장미과 과일)
(210, 'PEACH', '복숭아', 166), -- 과일타르트 (복숭아 토핑)

-- 사과 알레르기 (장미과 과일)
(211, 'APPLE', '사과', 166), -- 과일타르트 (사과 토핑)

-- 코코넛 알레르기 (견과류와 별도)
(212, 'COCONUT', '코코넛', 100), -- 초콜릿바나치노 (코코넛 토핑)
(213, 'COCONUT', '코코넛', 167), -- 초콜릿타르트 (코코넛 플레이크)

-- 바닐라 알레르기 (바닐린 민감성)
(214, 'VANILLA', '바닐라', 28), -- 바닐라라떼
(215, 'VANILLA', '바닐라', 29), -- 디카페인 바닐라라떼
(216, 'VANILLA', '바닐라', 30), -- 빅바나 바닐라라떼
(217, 'VANILLA', '바닐라', 31), -- 빅바나 디카페인 바닐라라떼
(218, 'VANILLA', '바닐라', 102), -- 바닐라바나치노
(219, 'VANILLA', '바닐라', 169), -- 바닐라파운드케이크

-- 꿀 알레르기
(220, 'HONEY', '꿀', 10), -- 허니아메리카노
(221, 'HONEY', '꿀', 11), -- 디카페인 허니아메리카노
(222, 'HONEY', '꿀', 66), -- 꿀라떼
(223, 'HONEY', '꿀', 67), -- 디카페인 꿀라떼
(224, 'HONEY', '꿀', 68); -- 빅바나 꿀라떼
