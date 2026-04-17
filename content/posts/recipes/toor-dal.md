---
title: "Toor Dal — A Story in Spice"
date: 2026-04-15
type: recipe
description: "Golden split pigeon peas, cooked until silken and cloud-soft, then crowned with a blazing tarka of mustard seeds, ginger, curry leaves, and ghee."
summary: "Golden split pigeon peas, cooked until silken and cloud-soft, then crowned with a blazing tarka of mustard seeds, ginger, curry leaves, and ghee. Ancient. Humble. Perfect."
hero: /images/posts/recipes/dal/dal-01.jpg
menu:
  sidebar:
    name: Toor Dal
    identifier: toor-dal
    parent: recipes
    weight: 10
---

<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=DM+Mono:wght@300;400&display=swap" rel="stylesheet">

<style>
.recipe-content {
  --saffron: #E8912A;
  --turmeric: #D4A017;
  --ghee: #F5E6C8;
  --deep: #1C1208;
  --ink: #2D1F0A;
  --smoke: #F9F4EC;
  --chili: #B83A22;
  --leaf: #3A5C34;
  --mustard: #8B6914;
  font-family: 'Cormorant Garamond', Georgia, serif;
  font-weight: 300;
  color: var(--ink);
  background: var(--smoke);
}
.recipe-content * { box-sizing: border-box; }
.recipe-content .hero {
  background: var(--deep);
  display: grid;
  grid-template-columns: 1fr 1fr;
  min-height: 100vh;
  position: relative;
  overflow: hidden;
}
.recipe-content .hero::before {
  content: '';
  position: absolute;
  inset: 0;
  background: radial-gradient(ellipse at 30% 50%, rgba(232,145,42,0.15) 0%, transparent 60%),
              radial-gradient(ellipse at 80% 20%, rgba(212,160,23,0.1) 0%, transparent 50%);
  pointer-events: none;
}
.recipe-content .hero-text {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 80px 60px;
  z-index: 2;
}
.recipe-content .eyebrow {
  font-family: 'DM Mono', monospace;
  font-size: 10px;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--saffron);
  margin-bottom: 28px;
  opacity: 0.8;
}
.recipe-content .hero h1 {
  font-family: 'Cormorant Garamond', serif;
  font-weight: 300;
  font-size: clamp(52px, 7vw, 92px);
  line-height: 0.95;
  color: var(--ghee);
  margin-bottom: 12px;
}
.recipe-content .hero h1 em {
  font-style: italic;
  color: var(--saffron);
  margin-left: 0.25em;
}
.recipe-content .hero-subtitle {
  margin-top: 32px;
  font-size: 17px;
  line-height: 1.7;
  color: rgba(245,230,200,0.6);
  max-width: 380px;
  font-weight: 300;
  font-style: italic;
}
.recipe-content .hero-meta {
  margin-top: 56px;
  display: flex;
  gap: 40px;
}
.recipe-content .meta-item { display: flex; flex-direction: column; gap: 4px; }
.recipe-content .meta-label {
  font-family: 'DM Mono', monospace;
  font-size: 9px;
  letter-spacing: 0.25em;
  text-transform: uppercase;
  color: var(--saffron);
  opacity: 0.6;
}
.recipe-content .meta-value { font-size: 16px; color: var(--ghee); font-weight: 400; }
.recipe-content .hero-image-col {
  position: relative;
  overflow: hidden;
}
.recipe-content .hero-image-col img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
  opacity: 0.78;
  filter: saturate(1.2) contrast(1.05);
}
.recipe-content .hero-image-col::after {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(to right, var(--deep) 0%, transparent 30%, transparent 70%, var(--deep) 100%),
              linear-gradient(to bottom, var(--deep) 0%, transparent 20%, transparent 80%, var(--deep) 100%);
}
.recipe-content .spice-divider {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 16px;
  padding: 48px 0 24px;
  color: var(--turmeric);
}
.recipe-content .spice-divider span { font-size: 22px; opacity: 0.5; }
.recipe-content .spice-divider .line {
  width: 80px; height: 1px;
  background: linear-gradient(to right, transparent, var(--turmeric), transparent);
  opacity: 0.4;
}
.recipe-content .intro {
  max-width: 680px;
  margin: 0 auto;
  padding: 20px 40px 72px;
  text-align: center;
}
.recipe-content .intro p {
  font-size: 20px;
  line-height: 1.85;
  color: var(--ink);
  font-style: italic;
  font-weight: 300;
}
.recipe-content .intro p strong { font-style: normal; font-weight: 600; color: var(--chili); }
.recipe-content .section { max-width: 1100px; margin: 0 auto; padding: 0 40px; }
.recipe-content .section-label {
  font-family: 'DM Mono', monospace;
  font-size: 10px;
  letter-spacing: 0.35em;
  text-transform: uppercase;
  color: var(--mustard);
  margin-bottom: 40px;
  display: flex;
  align-items: center;
  gap: 20px;
}
.recipe-content .section-label::after {
  content: '';
  flex: 1;
  height: 1px;
  background: linear-gradient(to right, var(--turmeric), transparent);
  opacity: 0.3;
}
.recipe-content .ingredients-section {
  background: var(--deep);
  padding: 80px 0;
  margin: 0 0 80px;
}
.recipe-content .ingredients-inner {
  max-width: 1100px;
  margin: 0 auto;
  padding: 0 40px;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 80px;
  align-items: start;
}
.recipe-content .ingredient-photo { border-radius: 2px; overflow: hidden; position: relative; }
.recipe-content .ingredient-photo img {
  width: 100%;
  aspect-ratio: 3/4;
  object-fit: cover;
  display: block;
  filter: saturate(1.1);
}
.recipe-content .ingredient-photo-caption {
  position: absolute;
  bottom: 0; left: 0; right: 0;
  background: linear-gradient(to top, rgba(28,18,8,0.9), transparent);
  padding: 32px 20px 16px;
  font-family: 'DM Mono', monospace;
  font-size: 9px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: var(--saffron);
  opacity: 0.8;
}
.recipe-content .ingredient-list-wrap h2 {
  font-family: 'Cormorant Garamond', serif;
  font-weight: 300;
  font-size: 42px;
  color: var(--ghee);
  line-height: 1.1;
  margin-bottom: 48px;
}
.recipe-content .ingredient-list-wrap h2 em { color: var(--saffron); font-style: italic; }
.recipe-content .ingredient-group { margin-bottom: 36px; }
.recipe-content .ingredient-group-title {
  font-family: 'DM Mono', monospace;
  font-size: 9px;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--saffron);
  opacity: 0.5;
  margin-bottom: 16px;
}
.recipe-content .ingredient-item {
  display: flex;
  align-items: baseline;
  gap: 12px;
  padding: 10px 0;
  border-bottom: 1px solid rgba(245,230,200,0.06);
  color: var(--ghee);
  font-size: 17px;
  font-weight: 300;
}
.recipe-content .ingredient-item .dot {
  width: 4px; height: 4px;
  border-radius: 50%;
  background: var(--saffron);
  flex-shrink: 0;
  opacity: 0.6;
  position: relative;
  top: -2px;
}
.recipe-content .optional-tag {
  font-family: 'DM Mono', monospace;
  font-size: 8px;
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--saffron);
  opacity: 0.45;
  margin-left: auto;
}
.recipe-content .mosaic {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 3px;
  margin-bottom: 80px;
}
.recipe-content .mosaic-item { overflow: hidden; position: relative; }
.recipe-content .mosaic-item img {
  width: 100%;
  height: 100%;
  aspect-ratio: 3/4;
  object-fit: cover;
  display: block;
  transition: transform 0.6s ease, filter 0.6s ease;
  filter: saturate(1.05);
}
.recipe-content .mosaic-item.tall img {
  aspect-ratio: auto;
  min-height: 443px;
}
.recipe-content .mosaic-item:hover img { transform: scale(1.04); filter: saturate(1.3); }
.recipe-content .mosaic-item.tall { grid-row: span 2; }
.recipe-content .mosaic-caption {
  position: absolute;
  bottom: 0; left: 0; right: 0;
  background: linear-gradient(to top, rgba(28,18,8,0.85), transparent);
  padding: 28px 16px 12px;
  font-family: 'DM Mono', monospace;
  font-size: 9px;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: rgba(245,230,200,0.7);
  opacity: 0;
  transition: opacity 0.4s ease;
}
.recipe-content .mosaic-item:hover .mosaic-caption { opacity: 1; }
.recipe-content .steps-section { padding: 0 0 80px; }
.recipe-content .step-block {
  display: grid;
  grid-template-columns: 80px 1fr;
  gap: 0 40px;
  margin-bottom: 56px;
}
.recipe-content .step-number-col {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 4px;
}
.recipe-content .step-number {
  font-family: 'Cormorant Garamond', serif;
  font-size: 52px;
  font-weight: 300;
  color: var(--turmeric);
  opacity: 0.25;
  line-height: 1;
}
.recipe-content .step-line {
  width: 1px;
  flex: 1;
  background: linear-gradient(to bottom, var(--turmeric), transparent);
  opacity: 0.15;
  margin-top: 8px;
}
.recipe-content .step-content h3 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 26px;
  font-weight: 400;
  color: var(--chili);
  margin-bottom: 12px;
  letter-spacing: 0.02em;
}
.recipe-content .step-content p {
  font-size: 18px;
  line-height: 1.8;
  color: var(--ink);
  font-weight: 300;
  max-width: 600px;
}
.recipe-content .step-content p em { color: var(--mustard); font-style: italic; }
.recipe-content .step-image {
  margin-top: 20px;
  border-radius: 2px;
  overflow: hidden;
  max-width: 500px;
}
.recipe-content .step-image img { width: 100%; aspect-ratio: 3/4; object-fit: cover; display: block; filter: saturate(1.1) contrast(1.02); }
.recipe-content .tarka-header {
  background: linear-gradient(135deg, var(--chili) 0%, #8B2010 100%);
  padding: 60px 40px;
  position: relative;
  overflow: hidden;
}
.recipe-content .tarka-header::before {
  content: '\0924\0921\093C\0915\093E';
  position: absolute;
  right: 40px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 120px;
  color: rgba(255,255,255,0.06);
  font-family: serif;
  line-height: 1;
}
.recipe-content .tarka-header h2 {
  font-family: 'Cormorant Garamond', serif;
  font-weight: 300;
  font-size: 54px;
  color: white;
  line-height: 1;
  margin-bottom: 12px;
}
.recipe-content .tarka-header h2 em {
  font-style: italic;
  opacity: 0.7;
  font-size: 0.65em;
  display: block;
  font-weight: 300;
  margin-top: 4px;
}
.recipe-content .tarka-header p {
  color: rgba(255,255,255,0.65);
  font-size: 16px;
  font-style: italic;
  max-width: 480px;
  line-height: 1.7;
  margin-top: 20px;
}
.recipe-content .finish-section {
  background: var(--deep);
  padding: 100px 40px;
  text-align: center;
  position: relative;
  overflow: hidden;
}
.recipe-content .finish-section::before {
  content: '';
  position: absolute;
  inset: 0;
  background: radial-gradient(ellipse at 50% 100%, rgba(232,145,42,0.12), transparent 60%);
}
.recipe-content .finish-section h2 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 56px;
  font-weight: 300;
  font-style: italic;
  color: var(--ghee);
  margin-bottom: 24px;
  position: relative;
}
.recipe-content .finish-section p {
  font-size: 18px;
  line-height: 1.85;
  color: rgba(245,230,200,0.55);
  max-width: 580px;
  margin: 0 auto 48px;
  font-style: italic;
}
.recipe-content .finish-image-row {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  gap: 3px;
  max-width: 900px;
  margin: 0 auto;
  position: relative;
}
.recipe-content .finish-image-row img { width: 100%; aspect-ratio: 3/4; object-fit: cover; display: block; filter: saturate(1.15); }
.recipe-content .tips-box {
  background: rgba(232,145,42,0.06);
  border: 1px solid rgba(232,145,42,0.15);
  border-left: 3px solid var(--saffron);
  padding: 32px 36px;
  margin: 40px 0 0;
  max-width: 620px;
}
.recipe-content .tips-box h4 {
  font-family: 'DM Mono', monospace;
  font-size: 10px;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: var(--saffron);
  margin-bottom: 16px;
}
.recipe-content .tips-box ul { list-style: none; padding: 0; }
.recipe-content .tips-box li {
  font-size: 16px;
  line-height: 1.7;
  color: var(--ink);
  padding: 6px 0 6px 16px;
  position: relative;
  font-style: italic;
}
.recipe-content .tips-box li::before { content: '\2014'; position: absolute; left: 0; color: var(--turmeric); opacity: 0.5; }
.recipe-content .dark-label {
  font-family: 'DM Mono', monospace;
  font-size: 10px;
  letter-spacing: 0.35em;
  text-transform: uppercase;
  color: rgba(245,230,200,0.35);
  margin-bottom: 40px;
  display: flex;
  align-items: center;
  gap: 20px;
}
.recipe-content .dark-label::after {
  content: '';
  flex: 1;
  height: 1px;
  background: linear-gradient(to right, rgba(232,145,42,0.4), transparent);
  opacity: 0.5;
}
@media (max-width: 768px) {
  .recipe-content .hero { grid-template-columns: 1fr; }
  .recipe-content .hero-image-col { display: none; }
  .recipe-content .ingredients-inner { grid-template-columns: 1fr; gap: 40px; }
  .recipe-content .mosaic { grid-template-columns: 1fr 1fr; }
  .recipe-content .mosaic-item.tall { grid-row: span 2; }
  .recipe-content .step-block { grid-template-columns: 50px 1fr; gap: 0 20px; }
}
</style>

<div class="recipe-content">

<!-- HERO -->
<section class="hero">
  <div class="hero-text">
    <div class="eyebrow">A recipe from the heart</div>
    <h1>Toor <em>Dal</em></h1>
    <p class="hero-subtitle">
      Golden split pigeon peas, cooked until silken and cloud-soft, then crowned with a blazing tarka of mustard seeds, ginger, curry leaves, and ghee. Ancient. Humble. Perfect.
    </p>
    <div class="hero-meta">
      <div class="meta-item">
        <span class="meta-label">Serves</span>
        <span class="meta-value">2</span>
      </div>
      <div class="meta-item">
        <span class="meta-label">Total Time</span>
        <span class="meta-value">~45 min</span>
      </div>
      <div class="meta-item">
        <span class="meta-label">Difficulty</span>
        <span class="meta-value">Gentle</span>
      </div>
    </div>
  </div>
  <div class="hero-image-col">
    <img src="/images/posts/recipes/dal/dal-01.jpg" alt="Finished dal with cilantro">
  </div>
</section>

<!-- INTRO -->
<div class="spice-divider">
  <div class="line"></div>
  <span>&#10022;</span>
  <div class="line"></div>
</div>
<div class="intro">
  <p>
    In every Indian kitchen, dal is not merely a dish — it is a <strong>ritual</strong>. The pop of mustard seeds, the perfume of curry leaves hitting hot ghee, the slow simmer of turmeric-gold lentils — these are the sounds and smells of home. This is that recipe.
  </p>
</div>

<!-- INGREDIENTS -->
<section class="ingredients-section">
  <div class="ingredients-inner">
    <div class="ingredient-photo">
      <img src="/images/posts/recipes/dal/dal-02.jpg" alt="Whole spices and soaking lentils">
      <div class="ingredient-photo-caption">Whole spices &amp; washed toor dal</div>
    </div>
    <div class="ingredient-list-wrap">
      <div class="dark-label">What you'll need</div>
      <h2>The <em>Ingredients</em></h2>
      <div class="ingredient-group">
        <div class="ingredient-group-title">The Dal</div>
        <div class="ingredient-item"><span class="dot"></span> 1 cup Toor dal (split pigeon peas)</div>
        <div class="ingredient-item"><span class="dot"></span> 2½ cups water (for pressure cooking)</div>
        <div class="ingredient-item"><span class="dot"></span> 2–3 whole cloves <span class="optional-tag">optional</span></div>
        <div class="ingredient-item"><span class="dot"></span> Salt, to taste</div>
        <div class="ingredient-item"><span class="dot"></span> ½ tsp turmeric</div>
      </div>
      <div class="ingredient-group">
        <div class="ingredient-group-title">For the Tarka</div>
        <div class="ingredient-item"><span class="dot"></span> 2 tbsp ghee (or neutral oil)</div>
        <div class="ingredient-item"><span class="dot"></span> 1 tsp mustard seeds</div>
        <div class="ingredient-item"><span class="dot"></span> 7–8 garlic cloves, finely minced</div>
        <div class="ingredient-item"><span class="dot"></span> 1 small finger of ginger, grated</div>
        <div class="ingredient-item"><span class="dot"></span> 2–3 green chilies, slit lengthwise</div>
        <div class="ingredient-item"><span class="dot"></span> 1 tomato, diced</div>
        <div class="ingredient-item"><span class="dot"></span> 1 tsp turmeric</div>
        <div class="ingredient-item"><span class="dot"></span> 1 tsp sugar</div>
        <div class="ingredient-item"><span class="dot"></span> Pinch of asafoetida (hing) <span class="optional-tag">optional</span></div>
        <div class="ingredient-item"><span class="dot"></span> 10–12 curry leaves <span class="optional-tag">optional</span></div>
        <div class="ingredient-item"><span class="dot"></span> Fresh cilantro, to finish</div>
      </div>
    </div>
  </div>
</section>

<!-- PHOTO MOSAIC -->
<div class="section">
  <div class="section-label">The mise en place</div>
  <div class="mosaic">
    <div class="mosaic-item tall">
      <img src="/images/posts/recipes/dal/dal-03.jpg" alt="Golden toor dal">
      <div class="mosaic-caption">Golden toor dal, washed and ready</div>
    </div>
    <div class="mosaic-item">
      <img src="/images/posts/recipes/dal/dal-04.jpg" alt="Grated ginger">
      <div class="mosaic-caption">Fresh ginger, finely grated</div>
    </div>
    <div class="mosaic-item">
      <img src="/images/posts/recipes/dal/dal-05.jpg" alt="Tomatoes and green chilies" style="object-fit: contain; background: #1C1208;">
      <div class="mosaic-caption">Tomatoes &amp; slit green chilies</div>
    </div>
    <div class="mosaic-item">
      <img src="/images/posts/recipes/dal/dal-06.jpg" alt="Asafoetida">
      <div class="mosaic-caption">Asafoetida — the secret weapon</div>
    </div>
    <div class="mosaic-item">
      <img src="/images/posts/recipes/dal/dal-07.jpg" alt="Mustard seeds">
      <div class="mosaic-caption">Black mustard seeds</div>
    </div>
  </div>
</div>

<!-- STEPS: THE DAL -->
<div class="section steps-section" style="padding-top:60px;">
  <div class="section-label">Part one — The Dal</div>

  <div class="step-block">
    <div class="step-number-col"><div class="step-number">1</div><div class="step-line"></div></div>
    <div class="step-content">
      <h3>Rinse &amp; Soak</h3>
      <p>Wash 1 cup of toor dal thoroughly under cold running water until the water runs clear. For silkier, more digestible dal, <em>soak for at least 30 minutes</em> — this little act of patience rewards you enormously.</p>
      <div class="step-image"><img src="/images/posts/recipes/dal/dal-08.jpg" alt="Dal soaking"></div>
    </div>
  </div>

  <div class="step-block">
    <div class="step-number-col"><div class="step-number">2</div><div class="step-line"></div></div>
    <div class="step-content">
      <h3>Pressure Cook</h3>
      <p>Add the soaked dal to your pressure cooker with 2½ cups of water, 2–3 whole cloves, a pinch of salt, and ½ tsp turmeric. <em>Press your fingertip into the water — it should reach your first knuckle above the dal.</em> Cook on high pressure for 8–9 minutes. Don't worry if it's very soft — that's the beauty of it.</p>
      <div class="step-image"><img src="/images/posts/recipes/dal/dal-09.jpg" alt="Cooked dal"></div>
    </div>
  </div>

  <div class="step-block">
    <div class="step-number-col"><div class="step-number">3</div></div>
    <div class="step-content">
      <h3>Check &amp; Rest</h3>
      <p>Release pressure and check your dal. It should be fully tender, <em>melting gently</em> into the golden broth. Set aside while you prepare the tarka — the true soul of the dish.</p>
    </div>
  </div>
</div>

<!-- TARKA HEADER -->
<div class="tarka-header">
  <h2>The Tarka<em>the tempering — where the magic lives</em></h2>
  <p>Tarka (or tadka) is the ancient technique of blooming whole spices in hot fat, then cascading that sizzling, fragrant oil over the cooked dal. It transforms the simple into the sublime.</p>
</div>

<!-- STEPS: THE TARKA -->
<div class="section steps-section" style="padding-top:60px;">
  <div class="section-label">Part two — The Tarka</div>

  <div class="step-block">
    <div class="step-number-col"><div class="step-number">4</div><div class="step-line"></div></div>
    <div class="step-content">
      <h3>Bloom the Mustard Seeds</h3>
      <p>Heat a wide pan over medium heat. Add your ghee — <em>use ghee if you can; it elevates the flavour into something truly transcendent.</em> When shimmering, add the mustard seeds and a pinch of asafoetida. Listen for the seeds to begin popping — that crackle is your signal.</p>
      <div class="step-image"><img src="/images/posts/recipes/dal/dal-10.jpg" alt="Mustard seeds popping in ghee"></div>
    </div>
  </div>

  <div class="step-block">
    <div class="step-number-col"><div class="step-number">5</div><div class="step-line"></div></div>
    <div class="step-content">
      <h3>Build the Aromatic Base</h3>
      <p>Add the curry leaves (stand back — they will spit and sizzle gloriously), followed immediately by the grated ginger and garlic. Add the slit green chilies. Cook, stirring, until the garlic shows <em>the faintest golden blush</em> at its edges — about 2 minutes.</p>
      <div class="step-image"><img src="/images/posts/recipes/dal/dal-11.jpg" alt="Ginger garlic and curry leaves sizzling"></div>
    </div>
  </div>

  <div class="step-block">
    <div class="step-number-col"><div class="step-number">6</div><div class="step-line"></div></div>
    <div class="step-content">
      <h3>Add the Tomatoes &amp; Spices</h3>
      <p>If using onions, add them now and cook until translucent before adding the tomatoes. Tumble in the diced tomatoes. Add turmeric and <em>just a teaspoon of sugar</em> — this is the secret that balances everything. Cook for 2–3 minutes until the tomatoes soften and collapse into the fragrant, golden oil.</p>
      <div class="step-image"><img src="/images/posts/recipes/dal/dal-12.jpg" alt="Tomatoes cooking in tarka"></div>
    </div>
  </div>

  <div class="step-block">
    <div class="step-number-col"><div class="step-number">7</div><div class="step-line"></div></div>
    <div class="step-content">
      <h3>The Union</h3>
      <p>Pour the cooked dal into the tarka and stir gently to marry everything together. Add water if it feels too thick. <em>Taste. Want more heat?</em> Slit a couple more green chilies and drop them straight in. Simmer together for 5 minutes, letting the flavours find each other.</p>
      <div class="step-image"><img src="/images/posts/recipes/dal/dal-13.jpg" alt="Dal and tarka coming together"></div>
    </div>
  </div>

  <div class="step-block">
    <div class="step-number-col"><div class="step-number">8</div></div>
    <div class="step-content">
      <h3>The Finish</h3>
      <p>Scatter a generous handful of fresh cilantro over the surface. Let it rest there, wilting gently in the warmth. Adjust salt one final time. <em>Serve with rice or warm roti, and nothing else — it needs nothing else.</em></p>
      <div class="step-image"><img src="/images/posts/recipes/dal/dal-14.jpg" alt="Finished dal with cilantro"></div>
      <div class="tips-box">
        <h4>A few notes from the cook</h4>
        <ul>
          <li>Ghee over oil, always. The flavour difference is worlds apart.</li>
          <li>Asafoetida (hing) smells pungent raw but mellows beautifully when cooked — it also aids digestion wonderfully.</li>
          <li>Curry leaves are worth seeking out at an Indian grocery; nothing quite replicates their citrusy, savory magic.</li>
          <li>Don't fear a very soft dal — silky and tender is the goal, not al dente.</li>
          <li>Soaking the lentils first makes them easier to digest and speeds up cooking.</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<!-- FINISH -->
<section class="finish-section">
  <h2>Dal is love made edible.</h2>
  <p>Every household has its own version, passed down through memory rather than measurement. This is yours now — make it your own.</p>
  <div class="finish-image-row">
    <img src="/images/posts/recipes/dal/dal-15.jpg" alt="Dal simmering">
    <img src="/images/posts/recipes/dal/dal-16.jpg" alt="Dal with cilantro">
    <img src="/images/posts/recipes/dal/dal-17.jpg" alt="Final dal">
  </div>
</section>

</div>
