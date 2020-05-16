# LifeEvent

HumanLife における Event。

ユーザによる HumanLife 作成時は、運営が定義した LifeEvent 一覧から選んで、マスにペタペタしていくイメージ。  
ペタペタしつつ、一部の params (amount とか)を選択できるようにしておけば十分でしょう。

## Examples

### 皆が money +3000

```js
LifeEvent {
    target: all,
    type: gainLifeItem,
    params: {
        targets: [
            {
                key: 'money',
                type: money,
                amount: 3000,
            }
        ]
    }
}
```

### stock 1 つにつき、money +5000

```js
LifeEvent {
    target: myself,
    type: gainLifeItemPerOtherLifeItem,
    params: {
        targets: [
            {
                key: 'money',
                type: money,
                amount: 5000,
            }
        ]
        perLifeItem: stock,
    }
}
```

### サイコロをふり、出目 × 5000 の money を獲得

```js
LifeEvent {
    target: myself,
    type: gainLifeItemPerDiceRoll,
    params: {
        targets: [
            {
                key: 'money',
                type: money,
                amount: 5000,
            }
        ]
    }
}
```

### 火災保険があれば money +5000

```js
LifeEvent {
    target: myself,
    type: gainLifeItemIfExistOtherLifeItem,
    params: {
        targets: [
            {
                key: 'money',
                type: money,
                amount: 5000,
            }
        ]
        existOneOfLifeItem: [fireInsurance],
    }
}
```

### 配偶者がいれば、子供(男 1 女 2)が生まれる

```js
LifeEvent {
    target: myself,
    type: gainLifeItemIfExistOtherLifeItem,
    params: {
        targets: [
            {
                key: 'boy',
                type: childBoy,
                amount: 1,
            },
            {
                key: 'girl',
                type: childGirl,
                amount: 2,
            }
        ] ,
        existOneOfLifeItem: [spouse],
    }
}
```

### 配偶者がいれば、money +5000, stock +2000

```js
LifeEvent {
    target: myself,
    type: gainLifeItemIfExistOtherLifeItem,
    params: {
        targets: [
            {
                key: 'money',
                type: money,
                amount: 5000,
            },
            {
                key: 'stock',
                type: stock,
                amount: 2000,
            }
        ],
        existOneOfLifeItem: [spouse],
    }
}
```

### 歌手に転職

```js
LifeEvent {
    target: myself,
        type: exchangeLifeItems,
        params: {
            targets: [
                {
                    key: 'singer',
                    type: job,
                    amount: 1,
                }
            ],
            bases: [
                {
                    key: 'any', // 全職を対象とする特殊な key
                    type: job,
                    amount: 4000,
                }
            ]
        }
}
```

### stock 1 枚を 4000 円で購入する

```js
LifeEvent {
    target: myself,
    type: exchangeLifeItems,
    params: {
        targets: [
            {
                key: 'stock',
                type: stock,
                amount: 1,
            }
        ],
        bases: [
            {
                key: 'money',
                type: money,
                amount: 4000,
            }
        ]
    }
}
```

### money 5000 円払い、サイコロの出目 × 2000 円もらえるカジノに挑戦できる

```js
LifeEvent {
    target: myself,
    type: exchangeLifeItemsWithDiceRoll,
    params: {
        targets: [
            {
                key: 'money',
                type: money,
                amount: 2000,
            }
        ],
        bases: [
            {
                key: 'money',
                type: money,
                amount: 5000,
            }
        ]
    }
}
```

### 火災保険が無ければ house を失う

```js
LifeEvent {
    target: myself,
    type: loseLifeItemIfNotExistOtherLifeItem,
    params: {
        targets: [
            {
                key: 'house',
                type: house,
                amount: 1,
            }
        ],
        notExistOneOfLifeItem: [fireInsurance],
    }
}
```

### 株券が 50 枚以下なら money +5000

以下、以上、未満、超過 はまだ対応してない。
要検討

### 分岐路で、進みたい方向を選ぶ

```js
LifeEvent {
    target: myself,
    type: selectDirection,
    params: {
        directions: [
            'up',
            'left',
        ],
    }
}
```

### 分岐路で、サイコロの出目に応じて進む方向が決まる

```js
LifeEvent {
    target: myself,
    type: selectDirectionPerDiceRoll,
    params: {
        directions: [
            {
                direction: 'up',
                weight: 1, // 重み付けをもとに、出目を割り当てる
            },
            {
                direction: 'left',
                weight: 2,
            }
        ],
    }
}
```

### 分岐路で、特定のアイテムの存否に応じて進む方向が決まる

```js
LifeEvent {
    target: myself,
    type: selectDirectionPerLifeItem,
    params: {
        directions: [
            {
                direction: 'up',
                case: true, // job を持ってるなら
            },
            {
                direction: 'left',
                case: false, // job が無ければ
            }
        ],
        targetLifeItemType: [job]
    }
}
```
