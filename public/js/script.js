// 加载数据库
let attractionsData = null;

// 获取数据库内容
async function loadDatabase() {
    try {
        const response = await fetch('/api/random-attractions');
        
        if (!response.ok) {
            throw new Error(`API请求失败: ${response.status}`);
        }

        const attractions = await response.json();
        console.log('获取到的随机数据:', attractions);

        if (!attractions || attractions.length === 0) {
            console.warn('没有获取到数据，使用模拟数据');
            useMockData();
            return;
        }

        // 添加category属性到每个景点对象
        const processedAttractions = attractions.map(attraction => {
            return {
                ...attraction,
                // 确保tags是数组
                tags: typeof attraction.tags === 'string' ? 
                      JSON.parse(attraction.tags) : attraction.tags
            };
        });

        // 显示处理后的数据
        displayCards(processedAttractions);
    } catch (error) {
        console.error('加载数据失败:', error);
        useMockData();
    }
}

// 显示随机卡片
function displayCards(attractions) {
    const cardsContainer = document.querySelector('.cards-container');
    cardsContainer.innerHTML = '';
    
    attractions.forEach(attraction => {
        const card = createCard(attraction);
        cardsContainer.appendChild(card);
    });
}

// 添加刷新按钮事件
function addRefreshButton() {
    const header = document.querySelector('header');
    const refreshButton = document.createElement('button');
    refreshButton.textContent = '换一批';
    refreshButton.className = 'refresh-btn';
    refreshButton.onclick = loadDatabase;
    header.appendChild(refreshButton);
}

// 创建卡片元素
function createCard(attraction) {
    const card = document.createElement('div');
    card.className = 'card';
    
    // 解析JSON字符串的tags
    const tags = typeof attraction.tags === 'string' ? JSON.parse(attraction.tags) : attraction.tags;
    const tagsHtml = tags.map(tag => `<span class="tag">${tag}</span>`).join('');
    
    // 添加类别标签
    const categoryLabel = {
        'where_to_eat': '去哪吃',
        'where_to_play': '去哪玩',
        'where_to_run': '去哪跑',
        'where_to_shop': '去哪逛'
    };
    
    card.innerHTML = `
        <div class="category-label">${categoryLabel[attraction.category]}</div>
        <img src="${attraction.image_url}" alt="${attraction.name}" onerror="this.onerror=null; this.src='/images/default.jpg';">
        <div class="card-content">
            <h2>${attraction.name}</h2>
            <p class="location">${attraction.location}</p>
            <p class="description">${attraction.description}</p>
            <div class="tags">${tagsHtml}</div>
            <div class="card-actions">
                <button class="like-btn" onclick="handleLike(${attraction.id}, '${attraction.category}')">👍 喜欢</button>
                <button class="dislike-btn" onclick="handleDislike(${attraction.id}, '${attraction.category}')">👎 不喜欢</button>
            </div>
        </div>
    `;
    
    return card;
}

// 使用模拟数据
function useMockData() {
    console.warn('使用模拟数据 - 无法连接到数据库');
    const mockData = [
        {
            id: 1,
            category: 'where_to_eat',
            name: '示例餐厅',
            location: '深圳市南山区xx路xx号',
            description: '这是一个示例餐厅描述',
            image_url: '/images/default.jpg',
            tags: ['美食', '餐厅', '示例'],
            rating: 4.5
        },
        // 可以添加更多模拟数据...
    ];
    displayCards(mockData);
}

// 页面加载完成后初始化
document.addEventListener('DOMContentLoaded', () => {
    loadDatabase();
    addRefreshButton();
}); 