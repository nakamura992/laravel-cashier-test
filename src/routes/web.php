<?php

use App\Http\Controllers\PaymentController;
use Illuminate\Support\Facades\Route;

Route::get('', [PaymentController::class, 'index'])->name('index');
Route::post('/process', [PaymentController::class, 'process'])->name('process');

