// 加载数据库
let attractionsData = null;

// 获取数据库内容
async function loadDatabase() {
    try {
        const response = await fetch('database.json');
        const data = await response.json();
        attractionsData = data.attractions;
        displayRandomCards();
    } catch (error) {
        console.error('Error loading database:', error);
    }
}

// 修改初始化代码
document.addEventListener('DOMContentLoaded', () => {
    displayRandomCards();  // 直接显示卡片
    addRefreshButton();
});

// 从指定类别中随机选择景点
function getRandomAttractions() {
    const categories = Object.keys(attractionsData); // ['去哪吃', '去哪玩', '去哪跑', '去哪逛']
    const allAttractions = [];
    
    // 收集所有景点
    categories.forEach(category => {
        const categoryAttractions = attractionsData[category];
        allAttractions.push(...categoryAttractions);
    });
    
    // 随机打乱所有景点
    const shuffled = allAttractions.sort(() => 0.5 - Math.random());
    
    // 只返回前3个景点
    return shuffled.slice(0, 3);
}

// 显示随机卡片
function displayRandomCards() {
    const cardsContainer = document.querySelector('.cards-container');
    const randomAttractions = getRandomAttractions();
    
    cardsContainer.innerHTML = ''; // 清空现有卡片
    
    randomAttractions.forEach(attraction => {
        const card = createCard(attraction);
        cardsContainer.appendChild(card);
    });
}

// 创建卡片元素
function createCard(attraction) {
    const card = document.createElement('div');
    card.className = 'card';
    
    card.innerHTML = `
        <img src="${attraction.image}" alt="${attraction.name}">
        <div class="card-content">
            <h2>${attraction.name}</h2>
            <p class="location">${attraction.location}</p>
            <p class="description">${attraction.description}</p>
            <div class="card-actions">
                <button class="like-btn" onclick="handleLike('${attraction.id}')">👍 喜欢</button>
                <button class="dislike-btn" onclick="handleDislike('${attraction.id}')">👎 不喜欢</button>
            </div>
        </div>
    `;
    
    return card;
}

// 处理喜欢按钮点击
function handleLike(attractionId) {
    console.log('Liked:', attractionId);
    // 这里可以添加收藏功能或其他操作
}

// 处理不喜欢按钮点击
function handleDislike(attractionId) {
    console.log('Disliked:', attractionId);
    // 这里可以添加过滤功能或其他操作
}

// 添加刷新按钮事件
function addRefreshButton() {
    const header = document.querySelector('header');
    const refreshButton = document.createElement('button');
    refreshButton.textContent = '换一批';
    refreshButton.className = 'refresh-btn';
    refreshButton.onclick = displayRandomCards;
    header.appendChild(refreshButton);
} 