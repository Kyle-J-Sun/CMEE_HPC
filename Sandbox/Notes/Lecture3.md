# Day 3 of HPC NOTEs
## Coalescence in Ecology

### Dynamic Equilibrium

- Balance between `immigration` and extinction
- Also, Balance between `speciation` and extinction in 
- Species themselves are changing

### The Advantages of Coalescence

- Always at equilibrium
- Much faster
- Sampling based

### The Disadvantages of Coalescence

- Not ideal for time series
- Complex to program
- Fewer ways in which model can be changed

## What's Fractal?

- Two properties:
    1. Self-similar: like the copy of the whole if you look at smaller parts of it.
    2. They have dimension that is not a whole number.

- Example1: **Koch Curve**

| Dimension | Width | Size |          |
|:---------:|:-----:|:----:| ---------|
|     1     |   3   |   3  |  = $3^1$ |
|     2     |   3   |   9  |  = $3^2$ |
|     x     |   3   |   4  |  = $3^x$ |

4 = $3^x$ >> log(4) = $x \times log(3)$ >> x = 1.262

### What is not fractal?

- A line twice as wide is twice as big --> $x^1$ 
- A square twice as wide is four times as big --> $x^2$
- A cube twice as wide is eight times as big --> $x^3$

## Measuring fractal dimension
### The Stick Method

$$ c = 2 \times n \times r \times sin(\frac{\pi}{n})$$
$$ sin(\theta) \approx \theta $$
$$ c \approx 2 \times n \times r \times \frac{\pi}{n} = 2 \times \pi \times r $$

**Application of Stick method in Coastlines**

- Dimensions = 1 - gradient
$$C(\delta) = K \times \delta^{1-D}$$
$$log(C(\delta)) = log(K) + (1 - D) \times log(\delta)$$
where $\delta$ is stick size, K is a constant.

**Box Counting Algorithm**

- Dimensions = -1 $\times$ gradient
$$N(\delta) = K \times \delta^{-D}$$
$$log(N(\delta)) = log(K) + -D \times log(\delta)$$
where $N(\delta)$ is `number of hypercubes needed to cover the object`, K is constant, $\delta$ is Hypercube length.

**Comparison between two methods**

$$C(\delta) = \delta \times N(\delta) = K \times \delta^{1-D}$$

## The Mandelbrot set and Chaos

- Mandelbrot set
    - a particular set of complex numbers which has a highly convoluted fractal boundary when plotted.
    - **Two thins may happen for many iterations**
        1. The number becomes infinite and goes outside of the cycle
        2. Or, it stopped in `Limit Cycle`

- Complex Plane
    - a plane on which we can plot the Mandelbrot set

### Hausdorff Dimension

- an object has the property that the number of balls of radius r needed to cover the object grows proportionally to $r^{-d}$ as r becomes small

### Chaos - the Logistic map

- **Logistic Function**
$$\frac{d}{d_t}P(t) = r \times P(t) \times (1 - P(t))$$

- **Logistic Map**
$$ x_{n + 1} = r \times x_{n} \times (1 - x_{n} )$$

- **Deterministic Chaos**
    - is present in systems where a small change in the initial conditions dramatically changes the outcome

### Complex Numbers


## Fractals in Nature

### Heavey Tailed Distribution

- The distribution is from prediction of price of cottons, but becoming useful in ecology as well!

### Gaussian and Fat tailed dispersal

- Gaussian:
$$D_{1}(r) = K_1 \times exp(-\frac{x^2}{2 \times L^2})$$

- Fat tailed Dispersal
$$D_2(r) = K_2 \times [1 + (\frac{R}{L})^2]^\frac{\eta}{2}$$

### Species area relationship

- A `increasing straight line` between logarithm of number of species and logarigthm of area.

- **Power Law**
$$ S = c \times A^z$$

> Fractal patterns in species aboundance gives rise to the power law





