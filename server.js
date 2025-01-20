const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const path = require('path');
const app = express();

// 数据库连接配置
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'SQL123456!', // 请将这里的your_password替换为您的实际密码
    database: 'attractions_db',
    debug: true // 添加调试模式
});

// 测试数据库连接和查询
db.connect((err) => {
    if (err) {
        console.error('数据库连接错误:', err);
        return;
    }
    console.log('数据库连接成功！');
    
    // 测试每个表的数据
    const tables = ['where_to_eat', 'where_to_play', 'where_to_run', 'where_to_shop'];
    tables.forEach(table => {
        db.query(`SELECT COUNT(*) as count FROM ${table}`, (err, results) => {
            if (err) {
                console.error(`${table}表查询失败:`, err);
                return;
            }
            console.log(`${table}表中有 ${results[0].count} 条记录`);
            
            // 显示具体数据
            db.query(`SELECT * FROM ${table} LIMIT 1`, (err, results) => {
                if (err) {
                    console.error(`${table}表数据查询失败:`, err);
                    return;
                }
                console.log(`${table}表示例数据:`, results[0]);
            });
        });
    });
});

// 添加连接错误监听
db.on('error', (err) => {
    console.error('数据库连接出错:', err);
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
        console.error('数据库连接丢失');
    }
});

// 中间件配置
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname)));  // 添加根目录支持
app.use(express.static(path.join(__dirname, 'public')));

// API路由
// 获取随机抽取的数据
app.get('/api/random-attractions', (req, res) => {
    const query = `
        (SELECT id, name, location, description, image_url, rating, tags, status, created_at, updated_at, 'where_to_eat' as category 
        FROM where_to_eat WHERE status = 1)
        UNION ALL
        (SELECT id, name, location, description, image_url, rating, tags, status, created_at, updated_at, 'where_to_play' as category 
        FROM where_to_play WHERE status = 1)
        UNION ALL
        (SELECT id, name, location, description, image_url, rating, tags, status, created_at, updated_at, 'where_to_run' as category 
        FROM where_to_run WHERE status = 1)
        UNION ALL
        (SELECT id, name, location, description, image_url, rating, tags, status, created_at, updated_at, 'where_to_shop' as category 
        FROM where_to_shop WHERE status = 1)
        ORDER BY RAND()
        LIMIT 6
    `;

    db.query(query, (err, results) => {
        if (err) {
            console.error('随机抽取数据失败:', err);
            res.status(500).json({ 
                error: err.message,
                details: '查询数据库失败'
            });
            return;
        }
        
        console.log('成功获取随机数据:', results);
        res.json(results);
    });
});

// 添加根路由
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// 启动服务器
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
    console.log(`访问 http://localhost:${PORT} 查看应用`);
}); 