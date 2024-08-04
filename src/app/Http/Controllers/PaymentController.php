<?php

namespace App\Http\Controllers;

use Stripe\PaymentIntent;
use Stripe\Stripe;

class PaymentController extends Controller
{
    public function index()
    {
        Stripe::setApiKey(env('STRIPE_SECRET'));

        $intent = PaymentIntent::create([
            'amount' => 1000, // 金額
            'currency' => env('CASHIER_CURRENCY'), // 通貨
            'payment_method_types' => ['card'], // 支払い方法
        ]);

        return view('index', ['intent' => $intent]);
    }

    // 支払い完了後の処理
    public function process()
    {
        return view('complete');
    }
}
