# Exercise 5.3

## merge

各々 $a$ 個、$b$ 個の木を持つ二つのヒープを merge することを考える。

link が発生しない場合、$a + b$ ステップ必要で、$\Phi(d_{in1}) = a, \Phi(d_{in2}) = b, \Phi(d_{out}) = a+b$、したがって償却コストは $a_i = (a+b)+(a+b)-(a+b) = a+b$ となる。
マージ後のヒープの大きさを $n$ とおくと $a < \lfloor\log(n+1)\rfloor, b < \lfloor\log(n+1)\rfloor$ なので、$a+b < 2\lfloor\log(n+1)\rfloor$ が成り立ち、償却コストは $O(\log n)$ となる。

$k$ 回の link が発生する場合、 merge は $a+b+k$ ステップを要し、 $\Phi(d_{in1}) = a, \Phi(d_{in2}) = b, \Phi(d_{out}) = a+b-k$ なので、償却コストは $a_i = (a+b+k)+(a+b-k)-(a+b) = a+b$ で $O(\log n)$ が成り立つ。

## deleteMin

$a$ 個の木を持つヒープに deleteMin を適用することを考える。 removeMinTree の呼び出し、ts1 の rev どちらもたかだか $a$ ステップかかる。
$a < \lfloor\log(n + 1)\rfloor$ なので、どちらも $O(\log n)$ である。
また前述の通り merge も $O(\log n)$ なので、deleteMin の償却コストは $O(\log n)$ である。
