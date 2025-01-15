-- 设置字符编码
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET collation_connection = utf8mb4_unicode_ci;

-- 删除并创建数据库
DROP DATABASE IF EXISTS attractions_db;
CREATE DATABASE attractions_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE attractions_db;

-- 创建"去哪吃"表
CREATE TABLE where_to_eat (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    location VARCHAR(255) NOT NULL CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    description TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    image_url VARCHAR(255),
    rating DECIMAL(2, 1),
    tags JSON,
    status TINYINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '美食景点表';

-- 创建"去哪玩"表
CREATE TABLE where_to_play (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    location VARCHAR(255) NOT NULL CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    description TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    image_url VARCHAR(255),
    rating DECIMAL(2, 1),
    tags JSON,
    status TINYINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '娱乐景点表';

-- 创建"去哪跑"表
CREATE TABLE where_to_run (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    location VARCHAR(255) NOT NULL CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    description TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    image_url VARCHAR(255),
    rating DECIMAL(2, 1),
    tags JSON,
    status TINYINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '运动景点表';

-- 创建"去哪逛"表
CREATE TABLE where_to_shop (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    location VARCHAR(255) NOT NULL CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    description TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    image_url VARCHAR(255),
    rating DECIMAL(2, 1),
    tags JSON,
    status TINYINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT '购物景点表';

-- 创建索引
ALTER TABLE where_to_eat ADD INDEX idx_rating_eat (rating);
ALTER TABLE where_to_play ADD INDEX idx_rating_play (rating);
ALTER TABLE where_to_run ADD INDEX idx_rating_run (rating);
ALTER TABLE where_to_shop ADD INDEX idx_rating_shop (rating);

-- 插入"去哪吃"数据
INSERT INTO where_to_eat (name, location, description, image_url, rating, tags) VALUES 
('农场番茄炸蛋 From 七月柿', 
'南山区滨海大道3001号深圳湾体育中心负一楼打的广场负一层B109号', 
'柿子味道无敌浓郁的加强版番茄炒蛋，下饭首选', 
'images/food/Nongchang_Fanqie_Zhadan.jpg',
4.8, 
'["家常菜", "春茧", "日常", "100-150"]'),

('北京烤鸭 From 东兴楼', 
'南山区后海滨路后海汇3楼', 
'REAL from 北京的果木挂炉烤鸭', 
'images/food/Beijing_Kaoya.jpg',
4.6, 
'["北京菜", "聚会", "100-150"]'),

('宫保茄香虾球 From 马旺子川小馆', 
'科苑南路2888号深圳湾万象城2楼L246号', 
'来自成都的网红川菜馆的不辣的主菜，虾仁很新鲜', 
'images/food/Gongbao_Qiexiang_Xiaqiu.jpg',
4.5, 
'["川菜", "网红", "家庭", "100-200"]'),

('藤椒烤肉酱烤伊比利亚黑猪肋排 From pLease', 
'南山区滨海大道3001号深圳湾体育中心负一楼打的广场负一层B107号', 
'酸甜带辣，肉质鲜嫩', 
'images/food/Yibiliya_Leipai.jpg',
4.3, 
'["烧烤", "海鲜", "夜宵", "100-200"]'),

('千岛湖有机大鱼头 From 2046湘味厨房', 
'南山区兰香一街2号海王星辰大厦201', 
'鱼头鲜嫩入味，汤鲜味美，有点小辣', 
'images/food/Youji_Dayutou.jpg',
4.5, 
'["湘菜", "海鲜", "商务", "100-200"]'),

('招积茄子 From 小炳胜', 
'南山区文心五路海岸城购物中心负一层045号', 
'老牌粤菜馆的招牌茄子，外酥里嫩，甜咸搭配的永动机', 
'images/food/Zhaoji_Qiezi.jpg', 
4.4, 
'["粤菜", "家庭聚餐", "经典菜品", "100-150"]');

-- 插入"去哪玩"数据
INSERT INTO where_to_play (name, location, description, image_url, rating, tags) VALUES 
('25.1.11 关系中的观察技巧和沟通策略 From 君尚3019', 
'深圳 南山区 熹玥音乐茶空间(君尚3019店)', 
'关注活动，了解活动，报名加微信mblalong', 
'images/entertainment/01jun_shang_sha_long.jpg', 
3.5, 
'["讲座", "情侣", "职场", "沟通", "心理学", "公益性"]'),

('至25.01.18 圣域图绘—雪山世界的唐卡 From 深圳湾1号艺术中心', 
'深圳 南山区 深圳湾1号艺术中心（南区T7栋七层）', 
'圣域图绘—雪山世界的唐卡', 
'images/entertainment/02shen_yue_tu_hui.jpg', 
3.5, 
'["展览", "家庭", "朋友", "艺术", "文化", "公益性"]'),

('25.1.17-25.1.25 猫南北喜剧脱口秀 From 天利名城', 
'深圳市南山区天利名城购物中心B座6F', 
'海岸城脱口秀丨爆笑互动欢乐解压丨全国知名大咖丨猫南北喜剧x南山后海店', 
'images/entertainment/Mao_Nan_Bei_Xi_Ju_Tuo_Kou_Xiu.jpg', 
3.5, 
'["脱口秀", "朋友", "喜剧", "89-99"]'),

('25.2.22 林忆莲《回响 Resonance》2025 巡回演唱会深圳站 From 春茧体育馆', 
'深圳湾体育中心"春茧"体育场', 
'林忆莲《回响 Resonance》 2025 巡回演唱会', 
'images/entertainment/Lin_Yi_Lian_Hui_Xiang_Resonance.jpg', 
3.5, 
'["演出", "演唱会", "林忆莲", "380-1280"]'),

('至25.3.6 深圳湾公共艺术季 From 深圳人才公园', 
'深圳人才公园', 
'围绕"自然活力"主题的14件作品在深圳人才公园、深圳大学同时展出', 
'images/entertainment/03shen_zhen_wan_gong_gong_yi_shu_ji.jpg', 
3.5, 
'["展览", "家庭", "朋友", "艺术", "文化", "公益性"]');

-- 插入"去哪跑"数据
INSERT INTO where_to_run (name, location, description, image_url, rating, tags) VALUES 
('后海夜跑 From 人才公园', 
'深圳市南山区望海路与滨海大道交汇处人才公园', 
'夜跑打卡圣地，海风伴你爆燃卡路里', 
'images/sports/01Shenzhen_Talents_Park.jpg',
4.7, 
'["跑步", "公园", "健康", "公益性"]'),

('看日出 From 深圳湾公园日出剧场', 
'南山区望海路深圳湾公园C2区', 
'在深圳湾迎接 第一缕阳光', 
'images/sports/02Ri_Chu.jpg',
4.9, 
'["日出", "海景", "户外", "公益性"]'),

('打羽毛球 From 春茧体育馆', 
'南山区滨海大道3001号', 
'下班拎起球拍儿动起来', 
'images/sports/Yu_Ma_Qiu.jpg',
4.6, 
'["羽毛球", "体育馆", "团建", "需预订"]'),

('徒步深圳湾 From 深圳湾公园', 
'深圳湾公园从日出剧场-流花山-大运塔', 
'环境优美的滨海步道，适合慢跑和散步', 
'images/sports/Houhai_Trail.jpg',
4.5, 
'["跑步", "步道", "海景", "公益性"]');

-- 插入"去哪逛"数据
INSERT INTO where_to_shop (name, location, description, image_url, rating, tags) VALUES 
('BAY MARKET LUNA', 
'南山區科苑南路2888號', 
'深圳湾万象城打造的主题市集', 
'images/shopping/Bay_Market_Cat.jpg',
4.7, 
'["巨物装置", "娱乐", "快闪", "100-200"]');

