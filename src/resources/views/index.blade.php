<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>laravel-cashier</title>
</head>

<style>
    form {
        width: 50%;
        margin: 0 auto;
    }
</style>

<body>
    <form action="{{ route('process') }}" method="POST" id="payment-form">
        @csrf
        <input type="text" name="card-holder-name" placeholder="カード名義" required>
        <div id="card-element"></div>
        <button id="card-button" type="submit" data-secret="{{ $intent->client_secret }}">
            購入する
        </button>
    </form>

    <script src="https://js.stripe.com/v3/"></script>
    <script>
        const stripe = Stripe('{{ env('STRIPE_KEY') }}');
        // カード要素をstrip.jsで生成し、元の要素にマウント
        const elements = stripe.elements();
        const cardElement = elements.create('card');
        cardElement.mount('#card-element');

        const form = document.getElementById('payment-form');
        const cardButton = document.getElementById('card-button');
        const clientSecret = cardButton.dataset.secret;

        form.addEventListener('submit', async (e) => {
            e.preventDefault();

            const {
                paymentIntent,
                error
            } = await stripe.confirmCardPayment(clientSecret, {
                payment_method: {
                    card: cardElement,
                    billing_details: {
                        name: document.querySelector('input[name=card-holder-name]').value,
                    },
                },
            });

            if (error) {
                console.error(error.message);
            } else {
                form.submit();
            }
        });
    </script>

</body>

</html>
